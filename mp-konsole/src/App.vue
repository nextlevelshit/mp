<template>
  <pre>{{ customerList }}</pre>
  <InvoiceForm @json-generated="handleJsonGenerated"/>
  <div v-if="pdfUrl" class="fixed top-0 right-0 bottom-0 w-2/5 z-0 bg-gray-900 ">
    <!-- Embed your PDF viewer here -->
    <!-- You can add your PDF viewer component or embed code here -->
    <!-- Example using an iframe, replace with your PDF viewer component -->
    <iframe
        :src="pdfUrl"
        class="w-full h-full"
        frameborder="0"
    ></iframe>
    <!--      <iframe :src="pdfUrl" width="100vw" height="100vh"></iframe>-->
  </div>
</template>

<script>
import InvoiceForm from "@/components/InvoiceForm.vue";

export default {
  components: {
    InvoiceForm
  },
  data() {
    return {
      pdfUrl: null,
      customerList: []
    };
  },
  created() {
    this.fetchCustomers()
  },
  methods: {
    fetchCustomers() {
      console.log("Fetching customers");
      fetch("/api/mp-depot/v1/invoices", {
        method: "GET",
        headers: {
          Authorziation: "Bearer ece27ebc929e5fe9a7186a420f17672fcd3e60a4b33182b294300c5e7001f01fbeebed3e7503610f4c29cb656f0ecd1caeddfb36e0aacedc9641268da3f3dc230d41e7dcb73be38bda2a2b03e08be1d87fe9960ef939659bd785c28fc99b8799f0220bebda93e2828a53faca6d8c53f68f8d639e18c4e84c78dc9e3726f0977b"
        }
      }).then((response) => {
        if (response.ok) {
          return response.json();
        }
      })
          .then(({data}) => {
            this.customerList = data
          })
          .catch((error) => {
            console.error(error);
          });
    },
    handleJsonGenerated(json) {
      console.log(json);
      // Send JSON data to the backend to generate the PDF
      fetch("/api/mp-inkasso/v1/invoice", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(json)
      })
          .then((response) => {
            if (response.ok) {
              return response.blob();
            } else {
              throw new Error("Error generating PDF");
            }
          })
          .then((blob) => {
            // Display the generated PDF in an iframe
            this.pdfUrl = URL.createObjectURL(blob);
          })
          .catch((error) => {
            console.error(error);
          });
    }
  }
};
</script>
