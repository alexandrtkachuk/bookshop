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

var idBook,priceBook;

function setTempBookPrice(id,price) {
    idBook= id;
    priceBook=price;
    $('#price').val(price);
    //$('#idBook').val(id);
}

function sendNewPrice()
{
 
    var newPrice = $('#price').val();   
    $.post(
            "api/editprice",
            {
                price:newPrice,
                idbook:idBook
            },
            function (data)
            {
                //if(data)
                console.log(data );
                var t = $.parseJSON(data);
                
                //console.log(t.warings);
                if(t.warings==0)
                {
                    $('#messgenre').text('цена успешно изменина');
                }
                else
                {
                    $('#messgenre').text('Error№'+t.warings);

                }

            }
    );
}


function SendBuy(idOrder)
{
    //console.log(setstatus); setstatus
    $.post(
            "api/setstatus",
            {
                id:idOrder
            },
            function (data)
            {
                //if(data)
                console.log(data );
                var t = $.parseJSON(data);
                
                //console.log(t.warings);
                if(t.warings==0)
                {
                    alert('статут успешно изменен');
                }
                else
                {
                    alert('Error№'+t.warings);

                }

            }
    );
}

