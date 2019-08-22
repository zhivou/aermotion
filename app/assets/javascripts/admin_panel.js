console.log("Modals Loaded");

function showPopup(id) {
  var popup = $('#exampleModalCenter');
  popup.find('#workout-modal').val(id);
  popup.modal('show');
}

function showRemove(id) {
  var popup = $('#removeWorkoutVideo');
  popup.find('#workout-modal').val(id);
  popup.modal('show');
}

function showUserPopup(id) {
  var popup = $('#addUserModal');
  popup.find('#workout-modal').val(id);
  popup.modal('show');
}

function showRemoveUser(id) {
  var popup = $('#removeWorkoutUser');
  popup.find('#workout-modal').val(id);
  popup.modal('show');
}