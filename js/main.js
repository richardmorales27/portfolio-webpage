// ========================================
// Mobile Navigation
// ========================================

const navToggle = document.querySelector(".nav-toggle");
const navLinks = document.querySelector(".nav-links");
const navItems = document.querySelectorAll(".nav-link");

navToggle.addEventListener("click", () => {
    navLinks.classList.toggle("nav-open");

    const isOpen = navLinks.classList.contains("nav-open");

    navToggle.setAttribute("aria-expanded", isOpen);
});


// Close mobile navigation after selecting a link

navItems.forEach((link) => {
    link.addEventListener("click", () => {
        navLinks.classList.remove("nav-open");
        navToggle.setAttribute("aria-expanded", "false");
    });
});


// ========================================
// Active Navigation Highlighting
// ========================================

const sections = document.querySelectorAll(
    "#home, #about, #portfolio, #resume, #contact"
);

const observerOptions = {
    root: null,
    threshold: 0.4
};

const sectionObserver = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {

        if (!entry.isIntersecting) {
            return;
        }

        navItems.forEach((link) => {
            link.classList.remove("active");
        });

        const activeLink = document.querySelector(
            `.nav-link[href="#${entry.target.id}"]`
        );

        if (activeLink) {
            activeLink.classList.add("active");
        }

    });
}, observerOptions);


sections.forEach((section) => {
    sectionObserver.observe(section);
});


// ========================================
// Entrance Animations
// ========================================

const animatedElements = document.querySelectorAll(
    ".skill-card, .about-container, .project-card, .resume-card"
);

const animationObserver = new IntersectionObserver(
    (entries, observer) => {

        entries.forEach((entry) => {

            if (!entry.isIntersecting) {
                return;
            }

            entry.target.classList.add("visible");

            observer.unobserve(entry.target);

        });

    },
    {
        threshold: 0.15
    }
);


animatedElements.forEach((element) => {
    element.classList.add("fade-in");
    animationObserver.observe(element);
});