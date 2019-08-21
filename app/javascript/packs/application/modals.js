// $('#myModal').on('shown.bs.modal', function () {
//   $('#myInput').trigger('focus')
// });

function showPopup(id) {
  debugger;
  var popup = $('#exampleModalCenter');
  popup.find('#w').value(id);
  popup.show();
}