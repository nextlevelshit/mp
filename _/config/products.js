const products = {
    covers: [
        {
            id: "HARD",
            url: "hardcover",
            name: "Notizbuch",
            variety: "Hardcover",
            options: "blanko oder kariert",
            price: 24.50,
            image: "/assets/products/HARD-3D-01.png",
            icon: "/assets/logos/hard-new.svg",
            sice: "150 x 210 mm",
            description: "160 Seiten",
            pattern: "24 Muster",
            binding: "Fadenheftung",
            active: true,
            headerTitle: "Hardcover",
            headerSubtitle: "",
            panelTitle: "Produktbeschreibung",
            panelContent: {
                text: "Alle Hardcover sind von uns selbst gestaltet, gedruckt und in Handarbeit gebunden. Die Buchdecken für die Hardcover werden durch das rot durchgefärbte und von Hand aufkaschierte Vorsatzpapier mit dem Buchblock verbunden. Ausgesuchte Materialien verleihen dem Buch zusammen mit den aufeinander abgestimmten Farben von Vorsatzpapier, Zeichen- und Kapitalband ein modernes Aussehen. Das eingesetzte, matte Recyclingpapier mit feiner Textur sorgt für angenehmes Schreiben und Skizzieren. Das mit Fadenheftung gebundene Buch hat ein optimales Aufschageverhalten und ist sehr strapazierfähig, auch bei intensivem Gebrauch.",
                format: "150 x 210 mm",
                cover: "mit zahlreichen, individuell konfigurierbaren Mustern bedruckt",
                content: "160 Seiten, wahlweise kariert oder blanko erhältlich.",
                paper: "alterungsbeständiges Recyclingpapier mit 1,4 fachem Volumen, hergestellt aus 100% Altpapier, 90g/qm, sowie alterungsbeständiges, holzfreies Premiumpapier mit Volumen, 150g/qm Hardcover-Überzug.",
                banderole: "Recyclingpapier, hergestellt aus 100% Altpapier, 120g/qm",
                details: "Hardcover mit rotem Vorsatzpapier, Fadenheftung. Textiles Kapital- und Zeichenband. Hergestellt in Deutschland."
            },
            slides: [{
                image: "/assets/images-landingpage/Hardcover-new.jpg",
                headline: "Hardcover",
                text: ""
            },
                {
                    image: "/assets/images-landingpage/HARD_00303.jpg",
                    headline: "Hardcover",
                    text: "Rotes Vorsatzpapier und Kapitalband"
                },
                {
                    image: "/assets/images-landingpage/HARD_9877.jpg",
                    headline: "Hardcover",
                    text: "Buchrücken"
                },
                {
                    image: "/assets/images-landingpage/HARD_00313.jpg",
                    headline: "Hardcover",
                    text: "Rotes Lesezeichen · Inhalt kariert"
                }
            ]
        },
        {
            id: "SOFT",
            url: "softcover",
            name: "Notizbuch",
            variety: "Softcover",
            options: "blanko oder kariert",
            price: 17.80,
            image: "/assets/products/SOFT-3D-01.png",
            icon: "/assets/logos/soft-new.svg",
            sice: "150 x 210 mm",
            description: "160 Seiten",
            pattern: "44 Muster",
            binding: "Fadenheftung",
            active: true,
            headerTitle: "Softcover",
            headerSubtitle: "",
            panelTitle: "Produktbeschreibung",
            panelContent: {
                text: "Alle Softcover sind von uns selbst gestaltet, gedruckt und in Handarbeit gebunden. Das eingesetzte, matte Recyclingpapier mit feiner Textur sorgt für angenehmes Schreiben und Skizzieren. Vorne und hinten ist jeweils ein rotes Vorschaltblatt eingefügt, was einen dezenten, farbigen Kontrast zu dem ansonsten absichtlich, schwarz-weiß gehaltenen Design setzt. Das mit Fadenheftung gebundene Buch hat ein optimales Aufschageverhalten und ist sehr strapazierfähig, auch bei intensivem Gebrauch.",
                format: "150 x 210 mm",
                cover: "mit zahlreichen, individuell konfigurierbaren Mustern bedruckt",
                content: "160 Seiten, wahlweise kariert oder blanko erhältlich.",
                paper: "alterungsbeständiges Recyclingpapier mit 1,4 fachem Volumen, hergestellt aus 100% Altpapier, 90g/qm, sowie alterungsbeständiges, holzfreies Premiumpapier mit Volumen, 300g/qm Cover.",
                banderole: "Recyclingpapier, hergestellt aus 100% Altpapier, 120g/qm",
                details: "Softcover mit rotem Vorschaltblatt, Fadenheftung. Hergestellt in Deutschland.<br><br>"
            },
            slides: [{
                image: "/assets/images-landingpage/Softcover-new.jpg",
                headline: "Softcover",
                text: ""
            },
                {
                    image: "/assets/images-landingpage/SOFT_00310.jpg",
                    headline: "Softcover",
                    text: "Rotes Vorschaltblatt"
                },
                {
                    image: "/assets/images-landingpage/SOFT_9879.jpg",
                    headline: "Softcover",
                    text: "Buchrücken"
                },
                {
                    image: "/assets/images-landingpage/SOFT_00315.jpg",
                    headline: "Softcover",
                    text: "Inhalt kariert"
                }
            ]
        },
        {
            id: "HEFT",
            url: "notebook",
            name: "Steppstich",
            variety: "Hefte",
            options: "blanko, kariert oder dotted",
            price: 7.50,
            image: "/assets/products/HEFT-3D-01.png",
            icon: "/assets/logos/heft-new.svg",
            sice: "150 x 210 mm",
            description: "40/60/80 Seiten",
            pattern: "44 Muster",
            binding: "Steppstich",
            active: true,
            headerTitle: "Hefte",
            headerSubtitle: "",
            panelTitle: "Produktbeschreibung",
            panelContent: {
                text: "Alle Notizhefte sind von uns selbst gestaltet, gedruckt und in Handarbeit gebunden. Das eingesetzte, matte Recyclingpapier mit feiner Textur sorgt für angenehmes Schreiben und Skizzieren. Um den Inhalt liegt ein Matelbogen aus rot durchgefärbtem Papier, was einen dezenten, farbigen Kontrast zu dem ansonsten absichtlich, schwarz-weiß gehaltenen Design setzt. Das mit Singerstich-Heftung gebundene Heft ist sehr strapazierfähig, auch bei intensivem Gebrauch.",
                format: "150 x 210 mm",
                cover: "mit zahlreichen, individuell konfigurierbaren Mustern bedruckt",
                content: "40, 60, oder 80 Seiten, wahlweise kariert, blanko oder dotted erhältlich.",
                paper: "alterungsbeständiges Recyclingpapier mit 1,4 fachem Volumen, hergestellt aus 100% Altpapier, 90g/qm, sowie alterungsbeständiges, holzfreies Premiumpapier mit Volumen, 300g/qm Cover.",
                banderole: "Recyclingpapier, hergestellt aus 100% Altpapier, 120g/qm",
                details: "Steppstich-Heftung mit rotem Faden und Mantelbogen, Ecken abgerundet. Hergestellt in Deutschland.<br>"
            },
            slides: [{
                image: "/assets/images-landingpage/Heft-new.jpg",
                headline: "Heft",
                text: ""
            },
                {
                    image: "/assets/images-landingpage/HEFT_00293.jpg",
                    headline: "Heft",
                    text: "Roter Mantelbogen"
                },
                {
                    image: "/assets/images-landingpage/HEFT_00318.jpg",
                    headline: "Heft",
                    text: "Heftrücken"
                },
                {
                    image: "/assets/images-landingpage/HEFT_00292.jpg",
                    headline: "Heft",
                    text: "Inhalt blanko"
                }
            ]
        }
    ],
    patterns: [{
        title: "3D Muster",
        prefix: "3D-Muster",
        description: "3D-Visualisierungen",
        list: [{
            id: "3D-01",
            price: 0,
            image: "assets/patterns/3D-Muster-01.jpg",
            covers: ["HARD", "SOFT", "HEFT"],
            description: "",
            active: true
        },
            {
                id: "3D-02",
                price: 0,
                image: "assets/patterns/3D-Muster-02.jpg",
                covers: ["SOFT", "HEFT"],
                description: "",
                active: false,
                new: true
            },
            {
                id: "3D-03",
                price: 1,
                image: "assets/patterns/3D-Muster-03.jpg",
                covers: ["SOFT", "HEFT"],
                description: "",
                active: true
            },
            {
                id: "3D-04",
                price: 0,
                image: "assets/patterns/3D-Muster-04.jpg",
                covers: ["SOFT", "HEFT"],
                description: "",
                active: false
            },
            {
                id: "3D-05",
                price: 0,
                image: "assets/patterns/3D-Muster-05.jpg",
                covers: ["HARD", "SOFT", "HEFT"],
                description: "",
                active: true
            },
            {
                id: "3D-06",
                price: 0,
                image: "assets/patterns/3D-Muster-06.jpg",
                covers: ["HARD", "SOFT", "HEFT"],
                description: "",
                active: true
            },
            {
                id: "3D-07",
                price: 0,
                image: "assets/patterns/3D-Muster-07.jpg",
                covers: ["HARD", "SOFT", "HEFT"],
                description: "",
                active: true
            }
        ]
    },
        {
            title: "Klassische Muster",
            prefix: "class-Muster",
            description: "Déjà-vu",
            list: [{
                id: "class-01",
                name: "Klassische Muster",
                price: 0,
                image: "assets/patterns/class-Muster-01.jpg",
                covers: ["SOFT", "HEFT"],
                description: "",
                active: true
            },
                {
                    id: "class-02",
                    name: "Klassische Muster",
                    price: 0,
                    image: "assets/patterns/class-Muster-02.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "class-03",
                    name: "Klassische Muster",
                    price: 0,
                    image: "assets/patterns/class-Muster-03.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "class-04",
                    name: "Klassische Muster",
                    price: 0,
                    image: "assets/patterns/class-Muster-04.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "class-05",
                    name: "Klassische Muster",
                    price: 0,
                    image: "assets/patterns/class-Muster-05.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "class-06",
                    name: "Klassische Muster",
                    price: 0,
                    image: "assets/patterns/class-Muster-06.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "class-07",
                    name: "Klassische Muster",
                    price: 0,
                    image: "assets/patterns/class-Muster-07.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "class-08",
                    name: "Klassische Muster",
                    price: 0,
                    image: "assets/patterns/class-Muster-08.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }
            ]
        },
        {
            title: "Florale Muster",
            prefix: "flora-Muster",
            description: "Verspielt",
            list: [{
                id: "flora-01",
                name: "Florale Muster",
                price: 0,
                image: "assets/patterns/flora-Muster-01.jpg",
                covers: ["SOFT", "HEFT"],
                description: "",
                active: false
            },
                {
                    id: "flora-02",
                    name: "Florale Muster",
                    price: 0,
                    image: "assets/patterns/flora-Muster-02.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "flora-03",
                    name: "Florale Muster",
                    price: 0,
                    image: "assets/patterns/flora-Muster-03.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "flora-04",
                    name: "Florale Muster",
                    price: 0,
                    image: "assets/patterns/flora-Muster-04.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "flora-05",
                    name: "Florale Muster",
                    price: 0,
                    image: "assets/patterns/flora-Muster-05.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "flora-06",
                    name: "Florale Muster",
                    price: 0,
                    image: "assets/patterns/flora-Muster-06.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }
            ]
        },
        {
            title: "Freestile Muster",
            prefix: "free-Muster",
            description: "Frei skizziert",
            list: [{
                id: "free-01",
                name: "Freestile Muster",
                price: 0,
                image: "assets/patterns/free-Muster-01.jpg",
                covers: ["HARD", "SOFT", "HEFT"],
                description: "",
                active: true
            },
                {
                    id: "free-02",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-02.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "free-03",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-03.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-04",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-04.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-05",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-05.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-06",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-06.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-07",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-07.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "free-08",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-08.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-09",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-09.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-10",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-10.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "free-11",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-11.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "free-12",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-12.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-13",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-13.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-14",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-14.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "free-15",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-15.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "free-16",
                    name: "Freestile Muster",
                    price: 0,
                    image: "assets/patterns/free-Muster-16.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }
            ]
        },
        {
            title: "Geometrische Muster",
            prefix: "geo-Muster",
            description: "Klare Formen",
            list: [{
                id: "geo-01",
                name: "Geometrische Muster",
                price: 0,
                image: "assets/patterns/geo-Muster-01.jpg",
                covers: ["SOFT", "HEFT"],
                description: "",
                active: false
            },
                {
                    id: "geo-02",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-02.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "geo-03",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-03.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "geo-04",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-04.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-05",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-05.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-06",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-06.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-07",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-07.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-08",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-08.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-09",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-09.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                }, {
                    id: "geo-10",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-10.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                }, {
                    id: "geo-11",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-11.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-12",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-12.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-13",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-13.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-14",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-14.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "geo-15",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-15.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                }, {
                    id: "geo-16",
                    name: "Geometrische Muster",
                    price: 0,
                    image: "assets/patterns/geo-Muster-16.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                }
            ]
        },
        {
            title: "Linien Muster",
            prefix: "line-Muster",
            description: "Psychedelisch",
            list: [{
                id: "line-01",
                name: "Linien Muster",
                price: 0,
                image: "assets/patterns/line-Muster-01.jpg",
                covers: ["SOFT", "HEFT"],
                description: "",
                active: true
            },
                {
                    id: "line-02",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-02.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "line-03",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-03.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                },
                {
                    id: "line-04",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-04.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                }, {
                    id: "line-05",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-05.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                }, {
                    id: "line-06",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-06.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "line-07",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-07.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "line-08",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-08.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false
                }, {
                    id: "line-09",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-09.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "line-10",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-10.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true
                }, {
                    id: "line-11",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-11.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true,
                    new: false
                }, {
                    id: "line-12",
                    name: "Linien Muster",
                    price: 0,
                    image: "assets/patterns/line-Muster-12.jpg",
                    covers: ["HARD", "SOFT", "HEFT"],
                    description: "",
                    active: true,
                    new: false
                }
            ]
        },
        {
            title: "Text Muster",
            prefix: "Text-Muster",
            list: [{
                id: "txt-01",
                name: "Text Muster",
                price: 0,
                image: "assets/patterns/txt-Muster-01.jpg",
                covers: ["SOFT", "HEFT"],
                description: "",
                active: true
            },
                {
                    id: "txt-02",
                    name: "Text Muster",
                    price: 0,
                    image: "assets/patterns/txt-Muster-02.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                },
                {
                    id: "txt-03",
                    name: "Text Muster",
                    price: 0,
                    image: "assets/patterns/txt-Muster-03.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false

                },
                {
                    id: "txt-04",
                    name: "Text Muster",
                    price: 0,
                    image: "assets/patterns/txt-Muster-04.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: false

                },
                {
                    id: "txt-05",
                    name: "Text Muster",
                    price: 0,
                    image: "assets/patterns/txt-Muster-05.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true

                },
                {
                    id: "txt-06",
                    name: "Text Muster",
                    price: 0,
                    image: "assets/patterns/txt-Muster-06.jpg",
                    covers: ["SOFT", "HEFT"],
                    description: "",
                    active: true
                }

            ]
        }
    ],
    options: [
        {
            title: "Option",
            description: "Bitte wählen Sie das Design des Inhalts aus.",
            list: [
                {
                    id: "option-01",
                    icon: "/assets/logos/blanko.svg",
                    name: "Blanko",
                    price: 0,
                    covers: ["HARD", "SOFT", "HEFT"]
                },
                {
                    id: "option-02",
                    icon: "",
                    name: "Liniert",
                    price: 1.20,
                    covers: []
                },
                {
                    id: "option-03",
                    icon: "/assets/logos/kariert.svg",
                    name: "Kariert",
                    price: 1.20,
                    covers: ["HARD", "SOFT", "HEFT"]
                },
                {
                    id: "option-04",
                    icon: "/assets/logos/dotted.svg",
                    name: "Dotted",
                    price: 1.20,
                    covers: ["HEFT"]
                }
            ]
        },
        {
            title: "Seitenanzahl",
            description: "Bitte wählen Sie die Seitenanzahl aus.",
            list: [
                {
                    id: "pages-40",
                    name: "40 Seiten",
                    price: 0,
                    covers: ["HEFT"]
                },
                {
                    id: "pages-60",
                    name: "60 Seiten",
                    price: 1.00,
                    covers: ["HEFT"]
                },
                {
                    id: "pages-80",
                    name: "80 Seiten",
                    price: 2.00,
                    covers: ["HEFT"]
                }
            ]
        }

    ]

};

const patternsCovers = products.patterns.map((pattern) => {
    return pattern.list.map(({ covers, name, image, id }) => {
        return covers.map((cover) => {
            // const product = products.covers.find(({id}) => id === cover);

            return products.options.map((option) => {
                return option.list.map((optionDetails) => {

                        const product = products.covers.find(({id}) => id === cover);

                        return {
                            ...product,
                            pattern: {
                                id,
                                name,
                                image,
                                title: pattern.title,
                                prefix: pattern.prefix,
                                description: pattern.description
                            },
                            option: {
                                id: optionDetails.id,
                                icon: optionDetails.icon,
                                name: optionDetails.name
                            }
                        }

                        // return {
                        //     ...product,
                        //     option: {
                        //         ...option,
                        //         title,
                        //         description
                        //     }
                        // }
                    });
                // })

            // return {
            //     ...product,
            //     patterns: {
            //         id,
            //         name,
            //         image,
            //         title: patterns.title,
            //         prefix: patterns.prefix,
            //         description: patterns.description
            //     }
            // }
        });
        });
    });
}).flat(4);

const coversOptions = products.options.map(({ title, description, list }) => {
    return list.map((option) => {

        return option.covers.map((cover) => {
            const product = products.covers.find(({id}) => id === cover);

            return {
                ...product,
                option: {
                    ...option,
                    title,
                    description
                }
            }
        });
    })
}).flat(2);

// console.log(JSON.stringify(patternsCovers, null, 2));
console.log(JSON.stringify(patternsCovers, null, 2));
console.log(patternsCovers.length);