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
      console.log({Authorization: `Bearer ${import.meta.env.VITE_DEPOT_API_TOKEN}`});
      fetch("/api/mp-depot/v1/customers", {
        method: "GET",
        headers: {
          Authorization: `Bearer ${import.meta.env.VITE_DEPOT_API_TOKEN}`
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
