import { Project } from './types';

export const projects: Project[] = [
  {
    title: 'shootify',
    description:
      'my biggest passion project. basketbal vlaanderen made easy. a user-oriented platform that serves as an alternative to the official website, which i found to be unsatisfactory. leveraging the public api for data retrieval, this project was built with next.js and shadcn. behind the scenes, python is used to sync the data and store it in a postgres database so that more complex queries can be performed. authentication is handled by firebase.',
    date: '2025',
    link: 'https://shootify.be',
    technologies: [
      { name: 'next.js', link: 'https://nextjs.org/' },
      { name: 'shadcn', link: 'https://ui.shadcn.com/' },
      { name: 'python', link: 'https://www.python.org/' },
      { name: 'postgres', link: 'https://www.postgresql.org/' },
      { name: 'firebase', link: 'https://firebase.google.com/' },
    ],
  },
  {
    title: 'hublife',
    description:
      'explore an easy-to-use dashboard with customizable widgets and a clear overview of fun information. built with svelte and daisyui, this app was my personal project to dive deeper into svelte.',
    date: '2023',
    link: 'https://hublife.netlify.app/',
    technologies: [
      { name: 'svelte', link: 'https://svelte.dev/' },
      { name: 'daisyui', link: 'https://daisyui.com/' },
    ],
  },
  {
    title: 'phoenix todo',
    description:
      'a simple todolist app built with phoenix and elixir, featuring user authentication, internationalization, and the ability to create, edit, delete, and share todos with others. with this project, the goal was to familiarize myself with functional programming and the elixir language.',
    date: '2022',
    link: 'https://github.com/JaanLavaerts/todo-phoenix',
    technologies: [
      { name: 'phoenix', link: 'https://www.phoenixframework.org/' },
      { name: 'elixir', link: 'https://elixir-lang.org/' },
    ],
  },
  {
    title: 'minesweeper',
    description:
      'a fully functional minesweeper game in c# and wpf, following the mvvm pattern to separate the logic from the ui. featuring customizable grid sizes, difficulty levels, and a flooding feature. though styling was minimal, it delivers a challenging and engaging experience.',
    date: '2022',
    link: 'https://github.com/JaanLavaerts/minesweeper',
    technologies: [
      { name: 'c#', link: 'https://docs.microsoft.com/en-us/dotnet/csharp/' },
      { name: 'wpf', link: 'https://docs.microsoft.com/en-us/dotnet/desktop/wpf/overview/' },
      { name: 'mvvm', link: 'https://learn.microsoft.com/en-us/dotnet/architecture/maui/mvvm' },
    ],
  },
];
