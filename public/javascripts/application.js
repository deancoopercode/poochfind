function validateSubmitForm() {

    var x = document.getElementById("username").value;
    if (x == null || x == "") {
        alert("Username must be filled out");
        return false;
    }
    var x = document.getElementById("password").value;
    if (x == null || x == "") {
        alert("Password must be filled out");
        return false;
    }
    return true;
}
