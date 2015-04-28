function getCurrentTabTitleAndUrl(callback) {
  var queryInfo = {
    active: true,
    currentWindow: true
  };

  chrome.tabs.query(queryInfo, function(tabs) {
    var tab = tabs[0];
    var title = tab.title;
    var url = tab.url;
    
    console.assert(typeof url == 'string', 'tab.url should be a string');
    console.assert(typeof title == 'string', 'tab.title should be a string');

    callback(title, url);
  });
}

document.addEventListener('DOMContentLoaded', function() {
  getCurrentTabTitleAndUrl(function(title, url) {
    document.getElementById('markdown').value = "[" + title + "]" + "(" + url + ")";
  });
});
