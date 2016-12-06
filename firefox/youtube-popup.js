javascript:(function() {
	var url = location.href.replace("https://", "").replace("http://", "");
	if (url.indexOf('youtube.com') !== -1) {
		var width =  window.prompt("Width","800");
		if (width) {
			var height = width * 63.125 / 100;
			var args = "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,height="+height+",width="+width;
			window.open('http://youtube.lhaco.com/index.php?url='+url+'&l='+width+'&p=1', "youtube", args);
		}
	}
})();

