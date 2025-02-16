interface ColorMapping {
  color: string;
  keys: string[];
}

interface ColorMappingObject {
  [key: string]: string;
}

export interface StopPosition {
  x: number;
  y: number;
  color: string;
}

// RGB转十六进制
export function rgbToHex(r: number, g: number, b: number): string {
  const toHex = (n: number) => {
    const hex = n.toString(16);
    return hex.length === 1 ? '0' + hex : hex;
  };
  return `#${toHex(r)}${toHex(g)}${toHex(b)}`;
}

const mappings: ColorMapping[] = [
  {
    color: '#8cd6ee',
    keys: ['alt', 'ctrl', 'F1']
  },
  {
    color: '#8ca3ee',
    keys: ['alt', 'ctrl', 'F2']
  },
  {
    color: '#9b8cee',
    keys: ['alt', 'ctrl', 'F3']
  },
  {
    color: '#bd8ded',
    keys: ['alt', 'ctrl', 'F4']
  },
  {
    color: '#e48cee',
    keys: ['alt', 'ctrl', 'F5']
  },
  {
    color: '#ee8cdb',
    keys: ['alt', 'ctrl', 'F6']
  },
  {
    color: '#ef8fbd',
    keys: ['alt', 'ctrl', 'F7']
  },
  {
    color: '#ef8f92',
    keys: ['alt', 'ctrl', 'F8']
  },
  {
    color: '#e673c4',
    keys: ['alt', 'ctrl', 'F9']
  },
  {
    color: '#9571e8',
    keys: ['alt', 'ctrl', 'F10']
  },
  {
    color: '#e7ae18',
    keys: ['alt', 'ctrl', 'F11']
  },
  {
    color: '#e19257',
    keys: ['alt', 'ctrl', 'F12']
  },
  {
    color: '#f5f9b7',
    keys: ['alt', 'ctrl', 'shift', 'F1']
  },
  {
    color: '#f9ddb7',
    keys: ['alt', 'ctrl', 'shift', 'F2']
  },
  {
    color: '#f7c2ae',
    keys: ['alt', 'ctrl', 'shift', 'F3']
  },
  {
    color: '#f7aeae',
    keys: ['alt', 'ctrl', 'shift', 'F4']
  },
  {
    color: '#eda08d',
    keys: ['alt', 'ctrl', 'shift', 'F5']
  },
  {
    color: '#edb98d',
    keys: ['alt', 'ctrl', 'shift', 'F6']
  },
  {
    color: '#edda8d',
    keys: ['alt', 'ctrl', 'shift', 'F7']
  },
  {
    color: '#d2ed8d',
    keys: ['alt', 'ctrl', 'shift', 'F8']
  },
  {
    color: '#a6ed8d',
    keys: ['alt', 'ctrl', 'shift', 'F9']
  },
  {
    color: '#8dedce',
    keys: ['alt', 'ctrl', 'shift', 'F10']
  },
  {
    color: '#31e4f9',
    keys: ['alt', 'ctrl', 'shift', 'F11']
  },
  {
    color: '#8a88d0',
    keys: ['alt', 'ctrl', 'shift', 'F12']
  },
  {
    color: '#aee6ae',
    keys: ['alt', 'NUM0']
  },
  {
    color: '#bd4043',
    keys: ['alt', 'NUM1']
  },
  {
    color: '#dc96c7',
    keys: ['alt', 'NUM2']
  },
  {
    color: '#b54ac4',
    keys: ['alt', 'NUM3']
  },
  {
    color: '#bd9bdf',
    keys: ['alt', 'NUM4']
  },
  {
    color: '#5444c4',
    keys: ['alt', 'NUM5']
  },
  {
    color: '#9eb7e0',
    keys: ['alt', 'NUM6']
  },
  {
    color: '#57b4c8',
    keys: ['alt', 'NUM7']
  },
  {
    color: '#97ddcf',
    keys: ['alt', 'NUM8']
  },
  {
    color: '#4fc882',
    keys: ['alt', 'NUM9']
  },
  {
    color: '#f8b4b6',
    keys: ['alt', 'shift', 'F1']
  },
  {
    color: '#f9b3db',
    keys: ['alt', 'shift', 'F2']
  },
  {
    color: '#fab1f4',
    keys: ['alt', 'shift', 'F3']
  },
  {
    color: '#e2b3f9',
    keys: ['alt', 'shift', 'F4']
  },
  {
    color: '#cbb1fa',
    keys: ['alt', 'shift', 'F5']
  },
  {
    color: '#b0b3fb',
    keys: ['alt', 'shift', 'F6']
  },
  {
    color: '#b0d2fb',
    keys: ['alt', 'shift', 'F7']
  },
  {
    color: '#b3ecf9',
    keys: ['alt', 'shift', 'F8']
  },
  {
    color: '#b7f9d8',
    keys: ['alt', 'shift', 'F9']
  },
  {
    color: '#b7f9c2',
    keys: ['alt', 'shift', 'F10']
  },
  {
    color: '#56b3da',
    keys: ['alt', 'shift', 'F11']
  },
  {
    color: '#a669c7',
    keys: ['alt', 'shift', 'F12']
  },
  {
    color: '#f78a48',
    keys: ['alt', 'ctrl', 'NUM0']
  },
  {
    color: '#f9e746',
    keys: ['alt', 'ctrl', 'NUM1']
  },
  {
    color: '#bffa45',
    keys: ['alt', 'ctrl', 'NUM2']
  },
  {
    color: '#6dfa45',
    keys: ['alt', 'ctrl', 'NUM3']
  },
  {
    color: '#44fbbf',
    keys: ['alt', 'ctrl', 'NUM4']
  },
  {
    color: '#44c4fb',
    keys: ['alt', 'ctrl', 'NUM5']
  },
  {
    color: '#4476fb',
    keys: ['alt', 'ctrl', 'NUM6']
  },
  {
    color: '#9644fb',
    keys: ['alt', 'ctrl', 'NUM7']
  },
  {
    color: '#f744fb',
    keys: ['alt', 'ctrl', 'NUM8']
  },
  {
    color: '#fb4496',
    keys: ['alt', 'ctrl', 'NUM9']
  },
  {
    color: '#59a323',
    keys: ['ctrl', 'F1']
  },
  {
    color: '#35483c',
    keys: ['ctrl', 'F2']
  },
  {
    color: '#b89eb8',
    keys: ['ctrl', 'F3']
  },
  {
    color: '#b19eb8',
    keys: ['ctrl', 'F4']
  },
  {
    color: '#ab9eb8',
    keys: ['ctrl', 'F5']
  },
  {
    color: '#a59eb8',
    keys: ['ctrl', 'F6']
  },
  {
    color: '#9e9eb8',
    keys: ['ctrl', 'F7']
  },
  {
    color: '#9eb8b8',
    keys: ['ctrl', 'F8']
  },
  {
    color: '#b89eb1',
    keys: ['ctrl', 'F9']
  },
  {
    color: '#9eb1b8',
    keys: ['ctrl', 'F10']
  },
  {
    color: '#9eb89e',
    keys: ['ctrl', 'F11']
  },
  {
    color: '#b8b89e',
    keys: ['ctrl', 'F12']
  },
  {
    color: '#e66f68',
    keys: ['ctrl', 'NUM0']
  },
  {
    color: '#e7aa67',
    keys: ['ctrl', 'NUM1']
  },
  {
    color: '#e8d166',
    keys: ['ctrl', 'NUM2']
  },
  {
    color: '#dce965',
    keys: ['ctrl', 'NUM3']
  },
  {
    color: '#9de965',
    keys: ['ctrl', 'NUM4']
  },
  {
    color: '#22cc1e',
    keys: ['ctrl', 'NUM5']
  },
  {
    color: '#40e3aa',
    keys: ['ctrl', 'NUM6']
  },
  {
    color: '#40cbe3',
    keys: ['ctrl', 'NUM7']
  },
  {
    color: '#3f75e4',
    keys: ['ctrl', 'NUM8']
  },
  {
    color: '#743ee6',
    keys: ['ctrl', 'NUM9']
  },
  {
    color: '#f154da',
    keys: ['ctrl', 'shift', 'F1']
  },
  {
    color: '#e0a3f8',
    keys: ['ctrl', 'shift', 'F2']
  },
  {
    color: '#8d56f3',
    keys: ['ctrl', 'shift', 'F3']
  },
  {
    color: '#9c9cf8',
    keys: ['ctrl', 'shift', 'F4']
  },
  {
    color: '#60a3f4',
    keys: ['ctrl', 'shift', 'F5']
  },
  {
    color: '#b4f8fa',
    keys: ['ctrl', 'shift', 'F6']
  },
  {
    color: '#6cf4aa',
    keys: ['ctrl', 'shift', 'F7']
  },
  {
    color: '#c6fab4',
    keys: ['ctrl', 'shift', 'F8']
  },
  {
    color: '#d7f777',
    keys: ['ctrl', 'shift', 'F9']
  },
  {
    color: '#fac2da',
    keys: ['ctrl', 'shift', 'F10']
  },
  {
    color: '#a56fbf',
    keys: ['ctrl', 'shift', 'F11']
  },
  {
    color: '#83a34e',
    keys: ['ctrl', 'shift', 'F12']
  },
  {
    color: '#ecb182',
    keys: ['ctrl', 'shift', 'b']
  },
  {
    color: '#a6f4f2',
    keys: ['ctrl', 'shift', 'c']
  },
  {
    color: '#a6f4c1',
    keys: ['ctrl', 'shift', 'f']
  },
  {
    color: '#f4cfa6',
    keys: ['ctrl', 'shift', 'g']
  },
  {
    color: '#ece782',
    keys: ['ctrl', 'shift', 'h']
  },
  {
    color: '#82c7ec',
    keys: ['ctrl', 'shift', 'i']
  },
  {
    color: '#81edda',
    keys: ['ctrl', 'shift', 'j']
  },
  {
    color: '#b183eb',
    keys: ['ctrl', 'shift', 'k']
  },
  {
    color: '#ea84b9',
    keys: ['ctrl', 'shift', 'l']
  },
  {
    color: '#8393eb',
    keys: ['ctrl', 'shift', 'm']
  },
  {
    color: '#81eda2',
    keys: ['ctrl', 'shift', 'n']
  },
  {
    color: '#ea84ea',
    keys: ['ctrl', 'shift', 'o']
  },
  {
    color: '#ea849b',
    keys: ['ctrl', 'shift', 'p']
  },
  {
    color: '#c9f4a6',
    keys: ['ctrl', 'shift', 't']
  },
  {
    color: '#baec82',
    keys: ['ctrl', 'shift', 'u']
  },
  {
    color: '#f4f2a6',
    keys: ['ctrl', 'shift', 'v']
  },
  {
    color: '#a6c4f4',
    keys: ['ctrl', 'shift', 'x']
  },
  {
    color: '#f4aaa6',
    keys: ['ctrl', 'shift', 'y']
  },
  {
    color: '#bba6f4',
    keys: ['ctrl', 'shift', 'z']
  },
  {
    color: '#28232c',
    keys: ['shift', 'F1']
  },
  {
    color: '#b8ab9e',
    keys: ['shift', 'F2']
  },
  {
    color: '#3f3d4e',
    keys: ['shift', 'F3']
  },
  {
    color: '#b8a59e',
    keys: ['shift', 'F4']
  },
  {
    color: '#b8b19e',
    keys: ['shift', 'F5']
  },
  {
    color: '#30373f',
    keys: ['shift', 'F6']
  },
  {
    color: '#9eabb8',
    keys: ['shift', 'F7']
  },
  {
    color: '#9ea5b8',
    keys: ['shift', 'F8']
  },
  {
    color: '#9eb8b1',
    keys: ['shift', 'F9']
  },
  {
    color: '#b89eab',
    keys: ['shift', 'F10']
  },
  {
    color: '#b1b89e',
    keys: ['shift', 'F11']
  },
  {
    color: '#abb89e',
    keys: ['shift', 'F12']
  },
  {
    color: '#8e4065',
    keys: ['alt', 'F1']
  },
  {
    color: '#c477b6',
    keys: ['alt', 'F2']
  },
  {
    color: '#8c4aac',
    keys: ['alt', 'F3']
  },
  {
    color: '#8c76c7',
    keys: ['alt', 'F4']
  },
  {
    color: '#4552ab',
    keys: ['alt', 'F5']
  },
  {
    color: '#81bcc5',
    keys: ['alt', 'F6']
  },
  {
    color: '#58b474',
    keys: ['alt', 'F7']
  },
  {
    color: '#9fd599',
    keys: ['alt', 'F8']
  },
  {
    color: '#9ebe5c',
    keys: ['alt', 'F9']
  },
  {
    color: '#989138',
    keys: ['alt', 'F10']
  },
  {
    color: '#dcbda0',
    keys: ['alt', 'F11']
  },
  {
    color: '#7e3a3a',
    keys: ['alt', 'F12']
  },
  {
    color: '#795e4d',
    keys: ['F5']
  },
  {
    color: '#49623e',
    keys: ['F6']
  },
  {
    color: '#30ad72',
    keys: ['F7']
  },
  {
    color: '#963ea6',
    keys: ['F8']
  },
  {
    color: '#337d49',
    keys: ['F9']
  },
  {
    color: '#437e98',
    keys: ['F10']
  },
  {
    color: '#77a9b0',
    keys: ['F11']
  },
  {
    color: '#1e1c68',
    keys: ['F12']
  }
];

export const color_mappings: ColorMappingObject = mappings.reduce((acc, mapping) => {
  acc[mapping.color] = mapping.keys.join('-');
  return acc;
}, {} as ColorMappingObject);
