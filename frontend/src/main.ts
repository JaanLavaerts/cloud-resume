import './style.css';
import { Project } from './types';
import { projects } from './projects';
import Typed from 'typed.js';

function renderProjects(projects: Project[]) {
  const container = document.querySelector('#projects');

  projects.forEach((project) => {
    const projectElement = document.createElement('div');
    projectElement.classList.add('project');

    let description = project.description;

    project.technologies.forEach((word) => {
      description = description.replace(word.name, () => {
        return `<a href="${word.link}" target="_blank" class="bg-zinc-100 underline underline-offset-4">${word.name}</a>`;
      });
    });

    projectElement.innerHTML = `
      <li>
        <div class="block border-b border-neutral-100 pb-6">
          <div class="flex items-baseline justify-between">
            <a target="_blank" href="${project.link}" class="text-lg font-normal hover:text-neutral-500 flex items-center gap-2">
              ${project.title} 
              <!-- <i class="fa-solid fa-link text-xs"></i> -->
            </a>
          </div>
          <p class="mt-1 text-sm text-neutral-500">${description}</p>
        </div>
      </li>
    `;

    container && container.appendChild(projectElement);
  });
}

function setCurrentYear() {
  const yearElement = document.getElementById('current-year');
  if (yearElement) {
    const currentYear = new Date().getFullYear();
    yearElement.textContent = currentYear.toString();
  }
}

new Typed('#typed', {
  stringsElement: '#typed-string',
  typeSpeed: 50,
  backSpeed: 50,
  backDelay: 5000,
  startDelay: 200,
  loop: true,
});

function fetchVisitorCount() {
  fetch('https://func-resume-jaan.azurewebsites.net/api/IncrementVisitorCounter')
    .then((response) => response.json())
    .then((data) => {
      const countElement = document.getElementById('visitor-count');
      if (countElement) {
        countElement.textContent = "visitors: " + data.visitor_count.toString();
      }
    })
    .catch((error) => {
      console.error('Error fetching visitor count:', error);
    });
}

fetchVisitorCount();
renderProjects(projects);
setCurrentYear();