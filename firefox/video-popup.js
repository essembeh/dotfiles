javascript:(function() {
	var url = location.href;
	var width =  window.prompt("Width","800");
	if (width) {
		var args = null;
		if ( /https?:\/\/www.youtube.com/.exec(url) ) {
			var height = width * 63.125 / 100;
			url = "http://youtube.lhaco.com/index.php?url=" + url.replace("https://", "").replace("http://", "") + "&l=" + width + "&p=1";
			args = "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,height="+height+",width="+width;
		} else if ( /https?:\/\/www.twitch.tv/.exec(url) ) {
			var height = width * 9 / 16;
			var matcher = /.*twitch.tv\/(\w+)(\/.*)?/.exec(url);
			if (matcher && matcher.length > 2) {
				url = "https://player.twitch.tv/?channel=" + matcher[1];
				args = "directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,height="+height+",width="+width;
			}
		} else {
			alert("Unsupported source");
		}
		if (url != null && args !=  null) {
			window.open(url, "myPopup", args);
		}
	}
})();

