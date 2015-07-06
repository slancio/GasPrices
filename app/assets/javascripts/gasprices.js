;(function () {
  "use strict";

  var apiURL = "http://ejsgasprices.herokuapp.com/api/states";

  function fetchJSON(url, callback) {
    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {
      if (req.readyState == XMLHttpRequest.DONE) {
        if (req.status == 200) {
          callback(JSON.parse(req.responseText));
        } else {
          console.log('Error' + req.status);
        }
      }
    };

    req.open("GET", url, true);
    req.send();
  };

  function displayPriceData(data) {
    insertAtId('gas-state', data.states.name);
    insertAtId('gas-price', "$" + data.states.current_price + "/gal");
    displayLastUpdated(data);
  };

  function displayLastUpdated(priceData) {
    var dateString = new Date(Date.parse(priceData.last_updated));
    dateString = dateString.toUTCString().split(' ').splice(0, 4).join(' ');
    insertAtId('gas-date', dateString);
  };

  function buildStateList(JSONdata) {
    JSONdata.states.forEach(function(el, idx) {
      var content = "<option value=\"" + el.code.toLowerCase() +
                    "\">" + el.name + "</option>";
      appendAtId('gas-state-select', content);
    });

    var stateList = document.getElementById('gas-state-select');
    stateList.onchange = function () {
      var selectedState = stateList.options[stateList.selectedIndex].value; 
      fetchJSON(apiURL + "/" + selectedState, displayPriceData);
    };
  };

  function insertAtId(id, content) {
    document.getElementById(id).innerHTML = content;
  };

  function appendAtId(id, content) {
    document.getElementById(id).innerHTML += content;
  };

  fetchJSON(apiURL, buildStateList);
})();