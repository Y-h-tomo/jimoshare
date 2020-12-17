function ticket() {
    const submit = document.getElementById("buy-ticket");
    submit.addEventListener("click", (e) => {
        const XHR = new XMLHttpRequest();
        XHR.open("POST", "/posts", true);
        XHR.responseType = "json";
        XHR.send;
        XHR.onload = () => {
            if (XHR.status != 200) {
                alert(`Error ${XHR.status}: ${XHR.statusText}`);
                return null;
            }
            const item = XHR.response.post;
            const count = document.getElementById("count");
            const HTML = `残りチケット数は,${item.count}`;
            count.insertAdjacentHTML("afterend", HTML);
        };
        e.preventDefault();
    });
}

window.addEventListener("load", ticket);