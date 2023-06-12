let themes = {
    "light": "Light",
    "dark": "Dark",
    "high_contrast": "High Contrast"
};

function switch_theme(new_theme = "light") {
    var current_theme = window.localStorage.getItem("theme");
    var body = document.getElementsByTagName("body")[0];
    if (new_theme in themes) {
        window.localStorage.setItem('theme', new_theme);
        body.classList.remove(current_theme);
        body.classList.add(new_theme);
    } else {
        console.error(`Unknown theme '${new_theme}'`);
    }


    var label = document.querySelector(".theme-switcher > div[data-i=\"0\"] > h2 > button > span");
    label.innerHTML = themes[new_theme];
}

function setupThemeSwitcher() {
    // Add event listeners to the radio buttons
    var options = document.querySelectorAll("#theme-switcher-options > li > a");
    for (var i = 0; i < options.length; i++) {
        var theme = options[i].dataset.theme;
        console.log(theme)
        options[i].onclick = switch_theme.bind(options[i], theme);
    }
    
    // Set theme to the user set value on page load
    var current_theme = window.localStorage.getItem("theme");
    if (current_theme == null) {
        // Default to light theme
        current_theme = "light";
    }
    switch_theme(current_theme);
}

export {switch_theme, setupThemeSwitcher}