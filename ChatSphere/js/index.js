function toggleConv() {
    const convSection = document.getElementById('convSection');
    const membersSection = document.getElementById('membersSection');

    if (membersSection.classList.contains("w-[350px]")) {
        toggleMembers()
    }

    if (convSection.classList.contains("w-0")) {
        convSection.classList.remove("w-0");
        convSection.classList.add("w-[350px]");
        setTimeout(() => {
            convSection.classList.add("min-w-[250px]");
        }, 300);
    }
    else {
        convSection.classList.add('w-0');
        convSection.classList.remove("min-w-[250px]");
        convSection.classList.remove("w-[350px]");

    }
}

function toggleMembers() {
    const membersSection = document.getElementById('membersSection');
    const convSection = document.getElementById('convSection');

    if (convSection.classList.contains("w-[350px]")) {
        toggleConv()
    }

    if (membersSection.classList.contains("w-0")) {
        membersSection.classList.remove("w-0");
        membersSection.classList.add("w-[350px]");
        setTimeout(() => {
            membersSection.classList.add("min-w-[250px]");
        }, 300);
    }
    else {
        membersSection.classList.add('w-0');
        membersSection.classList.remove('min-w-[250px]');
        membersSection.classList.remove('w-[350px]');
    }
}