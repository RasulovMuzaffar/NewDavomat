//<%-- занесение продольного удлинения --%>
$(document).on('dblclick', 'tbody td[data-p]', function () {
    if (!$(this).children().is('input')) {
        var w = $(this).width();
        $(this).addClass('sel');
        var t = $(this).html();
        $(this).html('<input type="text" value="' + t + '" id="i1" class="inp1">');
        $(this).find('#i1').focus().select().width(w);
    }
    $('#i1').on('blur', function () {
        
        var t = $(this).val();
        if (!(!isNaN(parseFloat(t)) && isFinite(t) || t.length===0)) {
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
        var d = $('thead tr:eq(3) th:eq(' + (4 - 3) + ')').attr('data-d'); //data-d
    });
});