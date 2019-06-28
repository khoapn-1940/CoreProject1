$(document).on("click", ".open-AddBookDialog", function () {
    var myBookId = $(this).data('id');
    $("#addBookDialog").modal()
    $(".modal-body #bookId").val(myBookId);
    // As pointed out in comments, 
    // it is unnecessary to have to manually call the modal.
    // $('#addBookDialog').modal('show');
});