const fs = require('fs');
const path = require('path');

if (!process.env.DEPOT_TOKEN) {
	console.error("DEPOT_API_TOKEN was not provided");
	process.exit(1);
}


const apiUrl = 'http://localhost:5555/api';


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


async function seedProductImages() {
	try {
		const productImages = [];

		for (const fileName of imageFileNames) {
			const imagePath = path.join(rootDirectory, fileName);
			const imageBuffer = fs.readFileSync(imagePath);
			const imageBlob = new Blob([imageBuffer], {type: getImageType(fileName)})
			const cover = getProductCover(fileName);

			const body = new FormData();
			const name = [
				getProductCoverLabel(cover),
				getProductPatternLabel(fileName)
			].join(" – ");
			const bodyData = {name};

			body.append("files.images", imageBlob, fileName);
			body.append("data", JSON.stringify(bodyData));

			const response = await fetch(`${apiUrl}/product-images`, {
				method: 'POST',
				headers: {
					'Authorization': `Bearer ${process.env.DEPOT_TOKEN}`,
				},
				body
			});

			if (!response.ok) {
				throw new Error(`Failed to add image "${fileName}" - Status: ${response.status}`);
			}

			const {data} = JSON.parse(await response.text());

			productImages.push(data);
		}

		console.log(`${productImages.length} entries added to product images`);

		console.log('Database seeding completed');

		const rnd = Math.round(Math.random() * productImages.length);

		console.log(`Random product at position ${rnd}/${productImages.length}`);

		console.log(productImages[rnd]);

		return productImages;
	} catch (error) {
		console.error('Error seeding the database:', error.message);
	}
}


seedProductImages().catch(console.error);
