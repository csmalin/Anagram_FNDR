$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $("input[name='word']").keyup(function(e) {
    e.preventDefault();
    $.ajax({
      type: "get",
      url: "/"+$(e.currentTarget).text(),
      data: $('form').serialize(),
      dataType: 'json'
    })
    .done(function(data, status, xhr) {
      // console.log(data, status, xhr);
      $("#words").empty();
      data.words.forEach(function(word) {
        $("#words").append("<li>" + word + "</li>");
      });
    });
  });
});
