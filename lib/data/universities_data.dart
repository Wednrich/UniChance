import '../models/university.dart';

const universities = <University>[
  University(
    id: 'sdu',
    name: 'SDU University',
    city: 'Қаскелең',
    type: 'Жекеменшік университет',
    website: 'https://sdu.edu.kz',
    hasMilitaryDepartment: true,
    hasDormitory: true,
  ),
  University(
    id: 'aitu',
    name: 'Astana IT University',
    city: 'Астана',
    type: 'Ұлттық IT университет',
    website: 'https://astanait.edu.kz',
    hasMilitaryDepartment: false,
    hasDormitory: true,
  ),
  University(
    id: 'satbayev',
    name: 'Satbayev University',
    city: 'Алматы',
    type: 'Ұлттық зерттеу университеті',
    website: 'https://satbayev.university',
    hasMilitaryDepartment: true,
    hasDormitory: true,
  ),
  University(
    id: 'iitu',
    name: 'IITU',
    city: 'Алматы',
    type: 'Халықаралық IT университет',
    website: 'https://iitu.edu.kz',
    hasMilitaryDepartment: true,
    hasDormitory: true,
  ),
  University(
    id: 'enu',
    name: 'ENU',
    city: 'Астана',
    type: 'Ұлттық университет',
    website: 'https://enu.kz',
    hasMilitaryDepartment: true,
    hasDormitory: true,
  ),
];
