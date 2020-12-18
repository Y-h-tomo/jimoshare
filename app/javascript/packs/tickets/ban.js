history.pushState(null, null, location.href);
window.addEventListener("popstate", (e) => {
    history.go(1);
});
// history.pushState(null, null, null); //ブラウザバック無効化
// //ブラウザバックボタン押下時
// $(window).on("popstate", function(event) {
//     history.pushState(null, null, null);
//     window.alert("このページでブラウザバックすることは出来ません");
// });