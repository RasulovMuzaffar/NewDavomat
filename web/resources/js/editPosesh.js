//<%-- занесение продольного удлинения --%>
$(document).on('dblclick', 'tbody td[data-p]', function () {
    if (!$(this).children().is('input')) {
        var w = $(this).width();
        $(this).addClass('sel');
        var t = $(this).html();
        $(this).attr('data-old', t.length === 0 ? 0 : t);
        $(this).html('<input type="text" value="' + t + '" id="i1" class="inp1">');
        $(this).find('#i1').focus().select().width(w);
    }
    $('#i1').on('blur', function () {

        var t = $(this).val();
        if (!(!isNaN(parseFloat(t)) && isFinite(t) || t.length === 0)) {
            alert("Введите числовое значение!!!");
            $(this).val("");
            return;
        }
        var r = $(this).parent();
        $(r).removeClass('sel').html(t);
    });
    $('#i1').one('change', function () {
        var t = $(this).val();
        if (!(!isNaN(parseFloat(t)) && isFinite(t))) {
            return;
        }
        var k = $(this).parent();
        $(k).html(parseInt(t));
        $(k).removeClass('sel');
//        con.send('aaa06|' + $(k).parent().attr('data-id_roll') + ',' + t);
//data-id_user
//data-p
//data-d
        var id_user = $(k).parent().attr('data-id_user'); //data-id_user
        var d = $('thead tr:eq(3) th:eq(' + ($(k)[0].cellIndex - 3) + ')').attr('data-d'); //data-d
        var znach = $(this).val();
        var tip = $(k).attr('data-p')//data-p
//        console.log("id_user = %s     d = %s     znach = %s    tip = %s", id_user, d, znach, tip);
        $.post('servlet', {command: "add", id_st: id_user, data: d, znach: znach, tip: tip}, function (data) {
            console.log("---- " + data);
            if (data === "Success") {
                var old = parseInt($(k).attr('data-old'));
                if (tip === "1") {
                    $(k).parent().find('.prop').html(parseInt($(k).parent().find('.prop').html()) - old + parseInt(znach));
                } else {
                    $(k).parent().find('.uv_prop').html(parseInt($(k).parent().find('.uv_prop').html()) - old + parseInt(znach));
                }
                $(k).parent().find('.neUv_prop').html(parseInt($(k).parent().find('.prop').html()) - parseInt($(k).parent().find('.uv_prop').html()));
            }
        });
    });
});