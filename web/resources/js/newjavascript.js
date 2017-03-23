$(document).ready(function () {
    $('#btn').click({command: "getSum", x: 1001, y: "qwerty"}, function (event) {
        $.post('servlet', {command: event.data.command, id: event.data.x, name: event.data.y}, function (data) {
            console.log(data);
            document.getElementById("tbody1").innerHTML = data;
        });
    });
});

