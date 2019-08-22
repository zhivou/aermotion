console.log("Modals Loaded");

function showPopup(id) {
  var popup = $('#exampleModalCenter');
  popup.find('#workout-modal').val(id);
  popup.modal('show');
}