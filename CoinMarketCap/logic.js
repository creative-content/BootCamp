$( document ).ready(function() {

var myArray = []

$.ajax({
  method: "GET",
  url: 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=gbp&order=market_cap_desc&per_page=100&page=1&sparkline=false',
  dataType: "json",
  success: function(response) {
    myArray = response
    buildTable(myArray);
    console.log(myArray);
  }
});

$("#search-input").on('keyup', function() {
  var value = $(this).val();
  console.log('value:', value);
  var data = searchTable(value, myArray);
  buildTable(data);
});

function searchTable(value, data) {
  var filteredData = [];
  for (var i = 0; i < data.length; i++) {
    value = value.toLowerCase();
    var name = data[i].name.toLowerCase();

    if (name.includes(value)) {
      filteredData.push(data[i]);
    }
  }
  return filteredData;
}

function buildTable(data) {
  var table = document.getElementById('myTable');
  table.innerHTML = '';
  for (var i = 0; i < data.length; i++) {
    var color24h = "";
    if (data[i].market_cap_change_percentage_24h > 0)
      color24h = "green";
    if (data[i].market_cap_change_percentage_24h < 0)
      color24h = "red";

    var row = `<tr>

  <td>${data[i].market_cap_rank}</td>
  <td> <img width="25" src="${data[i].image}"> ${data[i].name}</td>
  <td>${new Intl.NumberFormat('en-GB', { style: 'currency', currency: 'GBP' }).format(data[i].market_cap)}</td>
  <td>${new Intl.NumberFormat('en-GB', { style: 'currency', currency: 'GBP' }).format(data[i].current_price)}</td>
  <td>${new Intl.NumberFormat('en-GB', { style: 'currency', currency: 'GBP' }).format(data[i].price_change_24h)}</td>
  <td>${new Intl.NumberFormat('en-GB', { style: 'currency', currency: 'GBP' }).format(data[i].circulating_supply)}</td>
  <td class="${color24h}" >%${data[i].market_cap_change_percentage_24h.toFixed(2)}</td>
  </tr>`
    table.innerHTML += row
  }
}
});
