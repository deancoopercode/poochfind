function validateSubmitSignupForm() {

    var missingFields = "";

    if (document.getElementById("username").value == "") {
        missingFields += "\nUsername";
    }
    if (document.getElementById("password").value == "") {
        missingFields += "\nPassword";
    }
    if (document.getElementById("imageurl").value == "") {
        missingFields += "\nImage URL";
    }
    if (document.getElementById("poochname").value == "") {
        missingFields += "\nPooch Name";
    }
    if (document.getElementById("poochbreed").value == "") {
        missingFields += "\nPooch Breed";
    }
    if (document.getElementById("poochimageurl").value == "") {
        missingFields += "\nPooch Image URL";
    }

    if (missingFields == "") {
      return true;
    }
    else {
      alert("Some fields are missing: " + missingFields);
      return false;
    }

}


function validateSubmitCommentForm() {

    var missingFields = "";

    if (document.getElementById("newCommentText").value == "") {
      alert("You didnt enter a comment");
      return false;
    }
    return true;

}



function validateSubmitPostForm() {

    var missingFields = "";

    if (document.getElementById("textarea").value == "") {
        missingFields += "\nComments";
    }
    if (document.getElementById("primaryimageurl").value == "") {
        missingFields += "\nImage URL/Video";
    }
    if (missingFields == "") {
      return true;
    }
    else {
      alert("Some fields are missing: " + missingFields);
      return false;
    }

}
