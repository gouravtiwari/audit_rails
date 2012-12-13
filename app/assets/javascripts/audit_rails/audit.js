$("a.visit-site").live("click", function() {
	params = { audit: { url: this.href, app_id: $("a.visit-site").attr("data-app-id") } };
	$.post("/audits", params);
	window.open(this.href);
	return false;
});