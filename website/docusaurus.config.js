const path = require('path');

module.exports = {
  title: 'FlutterFire',
  tagline: 'The official Firebase plugins for Flutter',
  url: 'https://firebase.flutter.dev',
  baseUrl: '/',
  favicon: 'img/favicon.ico',
  organizationName: 'FirebaseExtended',
  projectName: 'flutterfire',
  themeConfig: {
    announcementBar: {
      id: 'wip',
      content:
        'The FlutterFire documentation hub is currently a <b>work in progress</b>. Some documentation may be missing or incomplete.',
      backgroundColor: '#13B9FD',
      textColor: '#fff',
    },
    prism: {
      additionalLanguages: [
        'dart',
        'bash',
        'java',
        'kotlin',
        'objectivec',
        'swift',
        'groovy',
        'ruby',
        'json',
        'yaml',
      ],
    },
    navbar: {
      title: 'FlutterFire',
      links: [
        // {
        //   to: 'docs/overview',
        //   activeBasePath: 'docs',
        //   label: 'Docs',
        //   position: 'right',
        // },
        {
          href: 'https://github.com/firebaseextended/flutterfire',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Coming soon',
              to: '#',
            },
            // {
            //   label: 'Android Installation',
            //   to: 'docs/install/android',
            // },
            // {
            //   label: 'iOS Installation',
            //   to: 'docs/install/ios',
            // },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'Stack Overflow',
              href: 'https://stackoverflow.com/questions/tagged/flutterfire',
            },
            {
              label: 'Flutter',
              href: 'https://flutter.dev/',
            },
            {
              label: 'pub.dev',
              href: 'https://pub.dev/',
            },
          ],
        },
        {
          title: 'Social',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/FirebaseExtended/flutterfire',
            },
          ],
        },
      ],
      copyright: `<div style="margin-top: 3rem"><small>Except as otherwise noted, this work is licensed under a Creative Commons Attribution 4.0 International License, and code samples are licensed under the BSD License.</small></div>`,
    },
  },
  plugins: [
    require.resolve('docusaurus-plugin-sass'),
    require.resolve('@docusaurus/plugin-ideal-image'),
    path.resolve(__dirname, './docusaurus-plugins/source-versions'),
    path.resolve(__dirname, './docusaurus-plugins/source-api-reference'),
  ],
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          path: '../docs',
          sidebarPath: require.resolve('../docs/sidebars.js'),
          editUrl: 'https://github.com/FirebaseExtended/flutterfire/edit/next/docs/',
        },
        theme: {
          customCss: require.resolve('./src/styles.scss'),
        },
      },
    ],
  ],
};
