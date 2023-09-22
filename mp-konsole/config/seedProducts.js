const fs = require('fs');
const path = require('path');

if (!process.env.VITE_DEPOT_API_TOKEN) {
    console.error("VITE_DEPOT_API_TOKEN is not defined in the .env file.");
    process.exit(1);
}


const apiUrl = 'http://localhost:5555/api'


const rootDirectory = path.join(__dirname, 'products');


function getImageFileNames(directory) {
    return fs.readdirSync(directory).filter(file => {
        return file.endsWith('.jpg') || file.endsWith('.jpeg') || file.endsWith('.png') || file.endsWith('.gif');
    });
}

const imageFileNames = getImageFileNames(rootDirectory);

const getProductCover = (fileName) => {
    const ids = new Map([
        ["HARD", 1],
        ["SOFT", 2],
        ["HEFT", 3]
    ]);
    return ids.get(fileName.split("-").shift());
};

const getProductCoverLabel = (cover) => {
    const ids = new Map([
        [1, "Notizbuch Hardcover"],
        [2, "Notizbuch Softcover"],
        [3, "Notizheft"]
    ]);
    return ids.get(cover);
};

const getProductPattern = (fileName) => {
    const idStart = 85;
    const suffixes = ["3D-01",
        "3D-02",
        "3D-03",
        "3D-04",
        "3D-05",
        "3D-06",
        "3D-07",
        "class-01",
        "class-02",
        "class-03",
        "class-04",
        "class-05",
        "class-06",
        "class-07",
        "class-08",
        "flora-01",
        "flora-02",
        "flora-03",
        "flora-04",
        "flora-05",
        "flora-06",
        "free-01",
        "free-02",
        "free-03",
        "free-04",
        "free-05",
        "free-06",
        "free-07",
        "free-08",
        "free-09",
        "free-10",
        "free-11",
        "free-12",
        "free-13",
        "free-14",
        "free-15",
        "free-16",
        "geo-01",
        "geo-02",
        "geo-03",
        "geo-04",
        "geo-05",
        "geo-06",
        "geo-07",
        "geo-08",
        "geo-09",
        "geo-10",
        "geo-11",
        "geo-12",
        "geo-13",
        "geo-14",
        "geo-15",
        "geo-16",
        "line-01",
        "line-02",
        "line-03",
        "line-04",
        "line-05",
        "line-06",
        "line-07",
        "line-08",
        "line-09",
        "line-10",
        "line-11",
        "line-12",
        "txt-01",
        "txt-02",
        "txt-03",
        "txt-04",
        "txt-05",
        "txt-06"];

    const patternIds = suffixes.map((suffix, i) => [suffix, idStart + i]);

    return new Map(patternIds).get(fileName.split(".").shift().replace(/\w*-/, ""));
};

function getAllProductPages() {
    return new Map([
        ["40 Seiten", 1],
        ["60 Seiten", 2],
        ["80 Seiten", 3]
    ]);
}

function getAllProductRuling() {
    return new Map([
        ["Blanko", 1],
        ["Liniert", 2],
        ["Kariert", 3],
        ["Dotted", 4]
    ]);
}

const getProductPatternLabel = (fileName) => {
    const names = new Map([
        ["txt", "Textmuster"],
        ["line", "Linienmuster"],
        ["geo", "Geometrische Muster"],
        ["free", "Freestyle Muster"],
        ["flora", "Florale Muster"],
        ["class", "Klassische Muster"],
        ["3D", "3D Muster"],
    ]);

    const pattern = fileName.split(".").shift().replace(/\w*-/, "");


    const ordial = pattern.split("-").pop().split(".").shift();
    const label = `${names.get(pattern.split("-").shift())} #${ordial}`;

    return label;
};

function getImageType(fileName) {
    const types = new Map([["jpg", "image/jpg"], ["jpeg", "image/jpg"], ["png", "image/png"], ["gif", "image/gif"]]);

    return types.get(fileName.toLowerCase().split(".").pop());
}


async function seedProducts() {
    try {
        const products = [];

        for (const fileName of imageFileNames) {
            const imagePath = path.join(rootDirectory, fileName);
            const imageBuffer = fs.readFileSync(imagePath);
            const imageBlob = new Blob([imageBuffer], {type: getImageType(fileName)})
            const cover = getProductCover(fileName);
            const pattern = getProductPattern(fileName);
            const allPages = getAllProductPages();
            const allRulings = getAllProductRuling(fileName);

            for (const [pagesLabel, pages] of allPages) {
                for (const [rulingLabel, ruling] of allRulings) {
                    const body = new FormData();
                    const name = [
                        getProductCoverLabel(cover),
                        getProductPatternLabel(fileName),
                        pagesLabel,
                        rulingLabel
                    ].join(" – ");
                    const bodyData = {name, cover, pattern, pages, ruling};

                    body.append("files.image", imageBlob, fileName);
                    body.append("data", JSON.stringify(bodyData));

                    const response = await fetch(`${apiUrl}/products`, {
                        method: 'POST',
                        headers: {
                            'Authorization': `Bearer ${process.env.VITE_DEPOT_API_TOKEN}`,
                        },
                        body
                    })

                    if (!response.ok) {
                        throw new Error(`Failed to add image "${fileName}" - Status: ${response.status}`);
                    }

                    const {data} = JSON.parse(await response.text());

                    products.push(data);
                }
            }


        }

        console.log(`${products.length} entries added to products including image upload and all relations`);

        console.log('Database seeding completed');

        const rnd = Math.round(Math.random() * products.length);

        console.log(`Random product at position ${rnd}/${products.length}`);

        console.log(products[rnd]);

        return products;
    } catch (error) {
        console.error('Error seeding the database:', error.message);
    }
}


seedProducts().catch(console.error);
