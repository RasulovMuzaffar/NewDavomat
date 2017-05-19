function getList() {
    var kurs = $("#kurs").val();
    var sem = $("#sem").val();
    var h = $("#h").val();
    console.log(kurs);
    console.log(sem);
    console.log(h);
    if (isFinite(kurs) && isFinite(sem) && isFinite(h) && !isNaN(parseInt(h))) {
        $.post('servlet', {command: "getList", kurs: kurs, sem: sem, h: h}, function (data) {
            document.getElementById("listSt").innerHTML = data;
            console.log(data);
            document.getElementById("SP").removeAttribute('disabled');
        });
    } else {
        document.getElementById("h").style.border='1px solid #FF4040';
        
//        alert("Не все поля заполнены или не правильно заполнены!");
    }
}

function h_click(p){
    p.style.borderColor='#ccc';
}
