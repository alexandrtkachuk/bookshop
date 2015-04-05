function sendAuthorName()
{
    var aname = $('#nameauthor').val();

    if( aname.length<3)
    {

        console.log(aname.length);
        return 0;
    }


    $.post(
            "api/addauthor",
            {
                name:aname 
            },
            function (data)
            {
                 var t = $.parseJSON(data);
                if(t.warings==0)
                {
                    $('#messauthor').text('Успешно добавленно: '+ aname);
                }
                else
                {
                    $('#messauthor').text('Error№'+t.warings);

                }



            }
          );
}

function sendGenreName()
{
    var gname = $('#namegenre').val();

    if( gname.length<3)
    {

        console.log(gname.length);
        return 0;
    }


    $.post(
            "api/addgenre",
            {
                name:gname 
            },
            function (data)
            {
                //if(data)
                var t = $.parseJSON(data);
                //console.log(data );
                //console.log(t.warings);
                if(t.warings==0)
                {
                    $('#messgenre').text('Успешно добавленно:' + gname);
                }
                else
                {
                    $('#messgenre').text('Error№'+t.warings);

                }

            }
    );
}
