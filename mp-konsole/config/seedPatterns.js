const fs = require('fs');
const path = require('path');

if (!process.env.VITE_DEPOT_API_TOKEN) {
    console.error("VITE_DEPOT_API_TOKEN is not defined in the .env file.");
    process.exit(1);
}


const apiUrl = 'http://localhost:5555/api'


const rootDirectory = path.join(__dirname, 'patterns');


function getImageFileNames(directory) {
    return fs.readdirSync(directory).filter(file => {
        return file.endsWith('.jpg') || file.endsWith('.jpeg') || file.endsWith('.png') || file.endsWith('.gif');
    });
}

const imageFileNames = getImageFileNames(rootDirectory);

const getPatternName = (fileName) => {
    const names = new Map([
        ["txt", "Textmuster"],
        ["line", "Linienmuster"],
        ["geo", "Geometrische Muster"],
        ["free", "Freestyle Muster"],
        ["flora", "Florale Muster"],
        ["class", "Klassische Muster"],
        ["3D", "3D Muster"],
    ]);
    const prefix = fileName.split("-")[0];
    const ordial = fileName.split("-").pop().split(".").shift();

    return `${names.get(prefix)} #${ordial}`;
};

const getPatternDescription = (fileName) => {
    const names = new Map([
        ["txt", "Wort & Schrift"],
        ["line", "Psychedelisch"],
        ["geo", "Klare Formen"],
        ["free", "Frei skizziert"],
        ["flora", "Verspielt"],
        ["class", "Déjà-vu"],
        ["3D", "3D-Visualisierungen"],
    ]);

    return names.get(fileName.split("-")[0]);
};

function getImageType(fileName) {
    const types = new Map([["jpg", "image/jpg"], ["jpeg", "image/jpg"], ["png", "image/png"], ["gif", "image/gif"]]);

    return types.get(fileName.toLowerCase().split(".").pop());
}


async function seedPatterns() {
    try {
        const patterns = [];

        for (const fileName of imageFileNames) {
            const imagePath = path.join(rootDirectory, fileName);
            const imageBuffer = fs.readFileSync(imagePath);
            const imageBlob = new Blob([imageBuffer], {type: getImageType(fileName)})
            const name = getPatternName(fileName);
            const description = getPatternDescription(fileName);
            const body = new FormData();

            body.append("files.image", imageBlob, fileName);
            body.append("data", JSON.stringify({name, description}));

            const response = await fetch(`${apiUrl}/product-patterns`, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${process.env.VITE_DEPOT_API_TOKEN}`,
                },
                body
            })

            if (!response.ok) {
                throw new Error(`Failed to add image "${fileName}" - Status: ${response.status}`);
            }

            const { data } = JSON.parse(await response.text());

            patterns.push(data);
        }

        console.log(`${patterns.length} entries added to product-patterns including image upload`);

        console.log('Database seeding completed');

        return patterns;
    } catch (error) {
        console.error('Error seeding the database:', error.message);
    }
}


seedPatterns().then(r => console.log(r)).catch(e => console.error(e));
