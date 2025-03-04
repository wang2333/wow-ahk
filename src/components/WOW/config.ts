export interface StopPosition {
  x: number;
  y: number;
  color: string;
}

// RGB转十六进制
export function rgbToHex(r: number, g: number, b: number): string {
  // 确保值在0-255范围内
  r = Math.max(0, Math.min(255, r));
  g = Math.max(0, Math.min(255, g));
  b = Math.max(0, Math.min(255, b));

  // 转换为16进制并确保每个颜色通道都是两位数
  return '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
}

export function hexToRgb(hex: string): [number, number, number] {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  if (!result) {
    throw new Error('Invalid HEX color');
  }
  return [parseInt(result[1], 16), parseInt(result[2], 16), parseInt(result[3], 16)];
}

export const color_mappings2: Record<string, string> = {
  '#8cd6ee': 'alt-ctrl-F1',
  '#8ca3ee': 'alt-ctrl-F2',
  '#9b8cee': 'alt-ctrl-F3',
  '#bd8ded': 'alt-ctrl-F4',
  '#e48cee': 'alt-ctrl-F5',
  '#ee8cdb': 'alt-ctrl-F6',
  '#eF8fbd': 'alt-ctrl-F7',
  '#eF8F92': 'alt-ctrl-F8',
  '#e673c4': 'alt-ctrl-F9',
  '#9571e8': 'alt-ctrl-F10',
  '#e7ae18': 'alt-ctrl-F11',
  '#e19257': 'alt-ctrl-F12',
  '#F5F9b7': 'alt-ctrl-shift-F1',
  '#F9ddb7': 'alt-ctrl-shift-F2',
  '#F7c2ae': 'alt-ctrl-shift-F3',
  '#F7aeae': 'alt-ctrl-shift-F4',
  '#eda08d': 'alt-ctrl-shift-F5',
  '#edb98d': 'alt-ctrl-shift-F6',
  '#edda8d': 'alt-ctrl-shift-F7',
  '#d2ed8d': 'alt-ctrl-shift-F8',
  '#a6ed8d': 'alt-ctrl-shift-F9',
  '#8dedce': 'alt-ctrl-shift-F10',
  '#31e4F9': 'alt-ctrl-shift-F11',
  '#8a88d0': 'alt-ctrl-shift-F12',
  '#aee6ae': 'alt-NUM0',
  '#bd4043': 'alt-NUM1',
  '#dc96c7': 'alt-NUM2',
  '#b54ac4': 'alt-NUM3',
  '#bd9bdf': 'alt-NUM4',
  '#5444c4': 'alt-NUM5',
  '#9eb7e0': 'alt-NUM6',
  '#57b4c8': 'alt-NUM7',
  '#97ddcf': 'alt-NUM8',
  '#4fc882': 'alt-NUM9',
  '#F8b4b6': 'alt-shift-F1',
  '#F9b3db': 'alt-shift-F2',
  '#fab1F4': 'alt-shift-F3',
  '#e2b3F9': 'alt-shift-F4',
  '#cbb1fa': 'alt-shift-F5',
  '#b0b3fb': 'alt-shift-F6',
  '#b0d2fb': 'alt-shift-F7',
  '#b3ecF9': 'alt-shift-F8',
  '#b7F9d8': 'alt-shift-F9',
  '#b7F9c2': 'alt-shift-F10',
  '#56b3da': 'alt-shift-F11',
  '#a669c7': 'alt-shift-F12',
  '#F78a48': 'alt-ctrl-NUM0',
  '#F9e746': 'alt-ctrl-NUM1',
  '#bffa45': 'alt-ctrl-NUM2',
  '#6dfa45': 'alt-ctrl-NUM3',
  '#44fbbf': 'alt-ctrl-NUM4',
  '#44c4fb': 'alt-ctrl-NUM5',
  '#4476fb': 'alt-ctrl-NUM6',
  '#9644fb': 'alt-ctrl-NUM7',
  '#F744fb': 'alt-ctrl-NUM8',
  '#fb4496': 'alt-ctrl-NUM9',
  '#59a323': 'ctrl-F1',
  '#35483c': 'ctrl-F2',
  '#b89eb8': 'ctrl-F3',
  '#b19eb8': 'ctrl-F4',
  '#ab9eb8': 'ctrl-F5',
  '#a59eb8': 'ctrl-F6',
  '#9e9eb8': 'ctrl-F7',
  '#9eb8b8': 'ctrl-F8',
  '#b89eb1': 'ctrl-F9',
  '#9eb1b8': 'ctrl-F10',
  '#9eb89e': 'ctrl-F11',
  '#b8b89e': 'ctrl-F12',
  '#e66F68': 'ctrl-NUM0',
  '#e7aa67': 'ctrl-NUM1',
  '#e8d166': 'ctrl-NUM2',
  '#dce965': 'ctrl-NUM3',
  '#9de965': 'ctrl-NUM4',
  '#22cc1e': 'ctrl-NUM5',
  '#40e3aa': 'ctrl-NUM6',
  '#40cbe3': 'ctrl-NUM7',
  '#3F75e4': 'ctrl-NUM8',
  '#743ee6': 'ctrl-NUM9',
  '#F154da': 'ctrl-shift-F1',
  '#e0a3F8': 'ctrl-shift-F2',
  '#8d56F3': 'ctrl-shift-F3',
  '#9c9cF8': 'ctrl-shift-F4',
  '#60a3F4': 'ctrl-shift-F5',
  '#b4F8fa': 'ctrl-shift-F6',
  '#6cF4aa': 'ctrl-shift-F7',
  '#c6fab4': 'ctrl-shift-F8',
  '#d7F777': 'ctrl-shift-F9',
  '#fac2da': 'ctrl-shift-F10',
  '#a56fbf': 'ctrl-shift-F11',
  '#83a34e': 'ctrl-shift-F12',
  '#ecb182': 'ctrl-shift-b',
  '#a6F4F2': 'ctrl-shift-c',
  '#a6F4c1': 'ctrl-shift-f',
  '#F4cfa6': 'ctrl-shift-g',
  '#ece782': 'ctrl-shift-h',
  '#82c7ec': 'ctrl-shift-i',
  '#81edda': 'ctrl-shift-j',
  '#b183eb': 'ctrl-shift-k',
  '#ea84b9': 'ctrl-shift-l',
  '#8393eb': 'ctrl-shift-m',
  '#81eda2': 'ctrl-shift-n',
  '#ea84ea': 'ctrl-shift-o',
  '#ea849b': 'ctrl-shift-p',
  '#c9F4a6': 'ctrl-shift-t',
  '#baec82': 'ctrl-shift-u',
  '#F4F2a6': 'ctrl-shift-v',
  '#a6c4F4': 'ctrl-shift-x',
  '#F4aaa6': 'ctrl-shift-y',
  '#bba6F4': 'ctrl-shift-z',
  '#28232c': 'shift-F1',
  '#b8ab9e': 'shift-F2',
  '#3F3d4e': 'shift-F3',
  '#b8a59e': 'shift-F4',
  '#b8b19e': 'shift-F5',
  '#30373f': 'shift-F6',
  '#9eabb8': 'shift-F7',
  '#9ea5b8': 'shift-F8',
  '#9eb8b1': 'shift-F9',
  '#b89eab': 'shift-F10',
  '#b1b89e': 'shift-F11',
  '#abb89e': 'shift-F12',
  '#8e4065': 'alt-F1',
  '#c477b6': 'alt-F2',
  '#8c4aac': 'alt-F3',
  '#8c76c7': 'alt-F4',
  '#4552ab': 'alt-F5',
  '#81bcc5': 'alt-F6',
  '#58b474': 'alt-F7',
  '#9fd599': 'alt-F8',
  '#9ebe5c': 'alt-F9',
  '#989138': 'alt-F10',
  '#dcbda0': 'alt-F11',
  '#7e3a3a': 'alt-F12',
  '#795e4d': 'F5',
  '#49623e': 'F6',
  '#30ad72': 'F7',
  '#963ea6': 'F8',
  '#337d49': 'F9',
  '#437e98': 'F10',
  '#77a9b0': 'F11',
  '#1e1c68': 'F12'
};

const data: Record<string, { color: string; com: string }> = {
  na: {
    color: '0,0,0',
    com: ''
  },
  startMove: {
    color: '52,0,0',
    com: ''
  },
  shadowFlame: {
    color: '97,2,0',
    com: ''
  },
  cancelStormPower: {
    color: '105,0,0',
    com: ''
  },
  casting: {
    color: '20,0,0',
    com: ''
  },
  kologarnTarget3: {
    color: '214,0,0',
    com: ''
  },
  shadowBite: {
    color: '34,2,0',
    com: ''
  },
  searL8: {
    color: '120,2,0',
    com: ''
  },
  cd: {
    color: '10,0,0',
    com: ''
  },
  unAffpettarget: {
    color: '103,4,0',
    com: ''
  },
  unAffmouseover: {
    color: '47,4,0',
    com: ''
  },
  corruptionmouseover: {
    color: '14,3,0',
    com: ''
  },
  corruptionpettarget: {
    color: '117,3,0',
    com: ''
  },
  corruptionL9: {
    color: '123,2,0',
    com: ''
  },
  drainSoulmouseover: {
    color: '2,6,0',
    com: ''
  },
  drainSoulpettarget: {
    color: '74,6,0',
    com: ''
  },
  agonypettarget: {
    color: '107,5,0',
    com: ''
  },
  agonymouseover: {
    color: '19,5,0',
    com: ''
  },
  immoparty1target: {
    color: '94,4,0',
    com: ''
  },
  immoparty2target: {
    color: '250,3,0',
    com: ''
  },
  immoparty3target: {
    color: '87,4,0',
    com: ''
  },
  immoparty4target: {
    color: '100,4,0',
    com: ''
  },
  immomouseover: {
    color: '47,4,0',
    com: ''
  },
  immopettarget: {
    color: '103,4,0',
    com: ''
  },
  immofocus: {
    color: '255,3,0',
    com: ''
  },
  sbmouseover: {
    color: '16,7,0',
    com: ''
  },
  sbpettarget: {
    color: '38,7,0',
    com: ''
  },
  sbL1pettarget: {
    color: '74,8,0',
    com: ''
  },
  sbL1mouseover: {
    color: '232,7,0',
    com: ''
  },
  tab: {
    color: '16,8,0',
    com: 'tab'
  },
  corruptionraid10target: {
    color: '241,2,0',
    com: 'SHIFT-DELETE'
  },
  rocketBoot: {
    color: '57,0,0',
    com: 'CTRL-F10'
  },
  agonyraid19target: {
    color: '172,4,0',
    com: 'ALT-CTRL-NUMPAD8'
  },
  sbL1raid14target: {
    color: '107,7,0',
    com: "ALT-CTRL-SHIFT-'"
  },
  feedPet: {
    color: '56,1,0',
    com: 'SHIFT-F4'
  },
  immo: {
    color: '40,1,0',
    com: 'SHIFT-F2'
  },
  burst2sb: {
    color: '112,1,0',
    com: 'CTRL-F6'
  },
  agonyraid18target: {
    color: '25,5,0',
    com: 'CTRL-SHIFT-NUMPAD8'
  },
  chaosBolt: {
    color: '34,1,0',
    com: 'ALT-CTRL-SHIFT-F2'
  },
  unAffraid12target: {
    color: '209,3,0',
    com: 'ALT-CTRL-PAGEDOWN'
  },
  drainSoulraid7target: {
    color: '83,5,0',
    com: 'ALT-CTRL-SHIFT-NUMPADPLUS'
  },
  agonyraid3target: {
    color: '63,4,0',
    com: 'SHIFT-NUMPAD6'
  },
  unAffraid16target: {
    color: '205,3,0',
    com: 'ALT-['
  },
  sbL1raid8target: {
    color: '147,7,0',
    com: "CTRL-'"
  },
  unAffraid10target: {
    color: '221,3,0',
    com: 'SHIFT-PAGEDOWN'
  },
  sbL1party2target: {
    color: '216,7,0',
    com: 'ALT-SHIFT-7'
  },
  agonyraid20target: {
    color: '14,5,0',
    com: 'ALT-SHIFT-NUMPAD8'
  },
  burst1sb: {
    color: '96,1,0',
    com: 'CTRL-F5'
  },
  drainSoulraid11target: {
    color: '111,5,0',
    com: 'CTRL-SHIFT-NUMPADMINUS'
  },
  agonyraid1target: {
    color: '132,4,0',
    com: 'CTRL-NUMPAD6'
  },
  unAffraid5target: {
    color: '181,3,0',
    com: 'ALT-CTRL-PAGEUP'
  },
  cancelToT: {
    color: '51,2,0',
    com: 'ALT-K'
  },
  inferno: {
    color: '31,1,0',
    com: 'ALT-SHIFT-F3'
  },
  sbL1party1target: {
    color: '45,8,0',
    com: 'ALT-CTRL-7'
  },
  drainSoulraid14target: {
    color: '136,5,0',
    com: 'ALT-CTRL-SHIFT-NUMPADMINUS'
  },
  corruptionraid16target: {
    color: '2,3,0',
    com: 'ALT-HOME'
  },
  sbL1raid13target: {
    color: '192,7,0',
    com: "ALT-SHIFT-'"
  },
  sbraid12target: {
    color: '177,6,0',
    com: 'ALT-CTRL-DOWN'
  },
  unAffraid22target: {
    color: '68,4,0',
    com: 'CTRL-]'
  },
  sbraid14target: {
    color: '225,6,0',
    com: 'ALT-CTRL-SHIFT-DOWN'
  },
  drainSoulparty4target: {
    color: '45,6,0',
    com: 'ALT-L'
  },
  drainSoulraid5target: {
    color: '152,5,0',
    com: 'ALT-CTRL-NUMPADPLUS'
  },
  drainSoulraid16target: {
    color: '226,5,0',
    com: 'ALT-NUMPADMULTIPLY'
  },
  sbraid1target: {
    color: '114,6,0',
    com: 'CTRL-UP'
  },
  agonyparty3target: {
    color: '54,5,0',
    com: 'SHIFT-M'
  },
  turn: {
    color: '79,8,0',
    com: 'ALT-F10'
  },
  tarBoss1: {
    color: '36,0,0',
    com: 'CTRL-NUMPAD0'
  },
  unAffraid13target: {
    color: '234,3,0',
    com: 'ALT-SHIFT-PAGEDOWN'
  },
  sbL1raid23target: {
    color: '203,7,0',
    com: 'ALT-.'
  },
  drainSoulparty1target: {
    color: '232,5,0',
    com: 'ALT-CTRL-M'
  },
  agonyparty4target: {
    color: '94,5,0',
    com: 'CTRL-SHIFT-M'
  },
  sbraid9target: {
    color: '172,6,0',
    com: 'ALT-DOWN'
  },
  sbL1raid6target: {
    color: '154,7,0',
    com: 'ALT-SHIFT-;'
  },
  healthStone: {
    color: '23,0,0',
    com: 'ALT-CTRL-SHIFT-F9'
  },
  agonyraid2target: {
    color: '160,4,0',
    com: 'ALT-NUMPAD6'
  },
  drainSoulraid21target: {
    color: '18,6,0',
    com: 'ALT-CTRL-SHIFT-NUMPADMULTIPLY'
  },
  unAffraid19target: {
    color: '212,3,0',
    com: 'ALT-CTRL-['
  },
  gate: {
    color: '141,1,0',
    com: 'CTRL-F4'
  },
  drainSoulraid13target: {
    color: '221,5,0',
    com: 'ALT-SHIFT-NUMPADMINUS'
  },
  sbraid19target: {
    color: '183,6,0',
    com: 'ALT-CTRL-LEFT'
  },
  teleport: {
    color: '125,1,0',
    com: 'ALT-CTRL-F3'
  },
  burst2agony: {
    color: '28,2,0',
    com: 'ALT-CTRL-F6'
  },
  drainSoulraid3target: {
    color: '67,5,0',
    com: 'SHIFT-NUMPADPLUS'
  },
  sbL1party4target: {
    color: '58,8,0',
    com: 'SHIFT-L'
  },
  drainSoulraid1target: {
    color: '88,5,0',
    com: 'CTRL-NUMPADPLUS'
  },
  burst3: {
    color: '111,8,0',
    com: 'CTRL-SHIFT-F9'
  },
  unAffraid11target: {
    color: '136,3,0',
    com: 'CTRL-SHIFT-PAGEDOWN'
  },
  drainSoulraid4target: {
    color: '123,5,0',
    com: 'CTRL-SHIFT-NUMPADPLUS'
  },
  unAffparty2target: {
    color: '250,3,0',
    com: 'ALT-SHIFT-N'
  },
  corruptionraid21target: {
    color: '54,3,0',
    com: 'ALT-CTRL-SHIFT-HOME'
  },
  corruptionraid9target: {
    color: '214,2,0',
    com: 'ALT-DELETE'
  },
  burst1unAff: {
    color: '194,1,0',
    com: 'SHIFT-F5'
  },
  sbraid22target: {
    color: '25,7,0',
    com: 'CTRL-RIGHT'
  },
  focusValkyr: {
    color: '201,0,0',
    com: 'CTRL-NUMPAD1'
  },
  burst3unAff: {
    color: '215,1,0',
    com: 'SHIFT-F7'
  },
  sbL1raid4target: {
    color: '94,7,0',
    com: 'CTRL-SHIFT-;'
  },
  saronite: {
    color: '33,8,0',
    com: 'ALT-SHIFT-F9'
  },
  sapper: {
    color: '42,8,0',
    com: 'ALT-CTRL-F9'
  },
  corruptionraid12target: {
    color: '230,2,0',
    com: 'ALT-CTRL-DELETE'
  },
  unAffraid23target: {
    color: '218,3,0',
    com: 'ALT-]'
  },
  sbraid16target: {
    color: '209,6,0',
    com: 'ALT-LEFT'
  },
  sb: {
    color: '218,0,0',
    com: 'CTRL-F1'
  },
  unAffraid25target: {
    color: '74,4,0',
    com: 'CTRL-SHIFT-]'
  },
  sbL1raid11target: {
    color: '82,7,0',
    com: "CTRL-SHIFT-'"
  },
  drainSoulraid24target: {
    color: '34,6,0',
    com: 'SHIFT-NUMPADDIVIDE'
  },
  sbL1raid5target: {
    color: '134,7,0',
    com: 'ALT-CTRL-;'
  },
  seed: {
    color: '195,0,0',
    com: 'CTRL-F2'
  },
  corruptionraid24target: {
    color: '67,3,0',
    com: 'SHIFT-END'
  },
  drainSoul: {
    color: '14,1,0',
    com: 'ALT-SHIFT-F1'
  },
  corruptionparty4target: {
    color: '112,3,0',
    com: 'CTRL-SHIFT-N'
  },
  burst2: {
    color: '102,8,0',
    com: 'SHIFT-F9'
  },
  doom: {
    color: '27,1,0',
    com: 'ALT-F2'
  },
  unAff: {
    color: '149,0,0',
    com: 'CTRL-SHIFT-F1'
  },
  tarLight: {
    color: '132,0,0',
    com: 'ALT-CTRL-NUMPAD1'
  },
  sbraid23target: {
    color: '196,6,0',
    com: 'ALT-RIGHT'
  },
  corruptionraid13target: {
    color: '201,2,0',
    com: 'ALT-SHIFT-DELETE'
  },
  burst2lifeTap: {
    color: '178,1,0',
    com: 'ALT-SHIFT-F6'
  },
  burst2Critical: {
    color: '145,2,0',
    com: 'CTRL-K'
  },
  drainSoulraid17target: {
    color: '245,5,0',
    com: 'SHIFT-NUMPADMULTIPLY'
  },
  sbL1raid1target: {
    color: '91,7,0',
    com: 'CTRL-;'
  },
  drainSoulraid15target: {
    color: '163,5,0',
    com: 'CTRL-NUMPADMULTIPLY'
  },
  agonyraid16target: {
    color: '229,4,0',
    com: 'ALT-NUMPAD8'
  },
  sbL1party3target: {
    color: '5,8,0',
    com: 'ALT-CTRL-SHIFT-7'
  },
  sbL1raid24target: {
    color: '10,8,0',
    com: 'SHIFT-.'
  },
  agonyraid5target: {
    color: '25,4,0',
    com: 'ALT-CTRL-NUMPAD6'
  },
  unAffraid17target: {
    color: '18,4,0',
    com: 'SHIFT-['
  },
  sbL1raid19target: {
    color: '151,7,0',
    com: 'ALT-CTRL-,'
  },
  agonyraid7target: {
    color: '91,4,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD6'
  },
  cancelHealthBuff: {
    color: '80,0,0',
    com: 'ALT-CTRL-SHIFT-F10'
  },
  burst3sb: {
    color: '152,1,0',
    com: 'CTRL-F7'
  },
  deathCoil: {
    color: '23,2,0',
    com: 'ALT-CTRL-F8'
  },
  seedmouseover: {
    color: '83,1,0',
    com: 'CTRL-SHIFT-F4'
  },
  drainSoulparty2target: {
    color: '252,5,0',
    com: 'ALT-SHIFT-M'
  },
  agonyraid9target: {
    color: '201,4,0',
    com: 'ALT-NUMPAD7'
  },
  sbraid4target: {
    color: '71,6,0',
    com: 'CTRL-SHIFT-UP'
  },
  drainSoulraid22target: {
    color: '176,5,0',
    com: 'CTRL-NUMPADDIVIDE'
  },
  drainSoulraid8target: {
    color: '120,5,0',
    com: 'CTRL-NUMPADMINUS'
  },
  drainSoulraid25target: {
    color: '58,6,0',
    com: 'CTRL-SHIFT-NUMPADDIVIDE'
  },
  demonicEmpowerment: {
    color: '77,1,0',
    com: 'SHIFT-F3'
  },
  drainSoulfocus: {
    color: '108,6,0',
    com: 'ALT-CTRL-NUMPADDIVIDE'
  },
  immoAura: {
    color: '72,1,0',
    com: 'ALT-CTRL-SHIFT-F3'
  },
  focusBoneSpike: {
    color: '121,0,0',
    com: 'ALT-SHIFT-NUMPAD0'
  },
  corruptionraid25target: {
    color: '80,3,0',
    com: 'CTRL-SHIFT-END'
  },
  sbraid21target: {
    color: '9,7,0',
    com: 'ALT-CTRL-SHIFT-LEFT'
  },
  agonyraid22target: {
    color: '212,4,0',
    com: 'CTRL-NUMPAD9'
  },
  burst1corruption: {
    color: '169,1,0',
    com: 'ALT-F5'
  },
  unAffparty1target: {
    color: '94,4,0',
    com: 'ALT-CTRL-N'
  },
  sbL1raid16target: {
    color: '197,7,0',
    com: 'ALT-,'
  },
  agonyraid6target: {
    color: '185,4,0',
    com: 'ALT-SHIFT-NUMPAD6'
  },
  haunt: {
    color: '227,0,0',
    com: 'ALT-F1'
  },
  agonyfocus: {
    color: '114,5,0',
    com: 'ALT-CTRL-NUMPAD9'
  },
  sbraid3target: {
    color: '39,6,0',
    com: 'SHIFT-UP'
  },
  sbraid10target: {
    color: '200,6,0',
    com: 'SHIFT-DOWN'
  },
  sbfocus: {
    color: '252,6,0',
    com: 'ALT-CTRL-RIGHT'
  },
  burst3haunt: {
    color: '47,2,0',
    com: 'CTRL-SHIFT-F7'
  },
  agonyparty1target: {
    color: '232,4,0',
    com: 'CTRL-M'
  },
  shatter: {
    color: '103,1,0',
    com: 'CTRL-SHIFT-F3'
  },
  doomfocus: {
    color: '181,1,0',
    com: 'CTRL-F8'
  },
  sbraid25target: {
    color: '156,6,0',
    com: 'CTRL-SHIFT-RIGHT'
  },
  corruptionraid5target: {
    color: '185,2,0',
    com: 'ALT-CTRL-INSERT'
  },
  drainSoulraid9target: {
    color: '183,5,0',
    com: 'ALT-NUMPADMINUS'
  },
  corruptionraid7target: {
    color: '116,2,0',
    com: 'ALT-CTRL-SHIFT-INSERT'
  },
  willToSurvive: {
    color: '89,0,0',
    com: 'ALT-SHIFT-F10'
  },
  soulFire: {
    color: '221,0,0',
    com: 'CTRL-SHIFT-F2'
  },
  corruptionraid15target: {
    color: '192,2,0',
    com: 'CTRL-HOME'
  },
  agonyraid21target: {
    color: '38,5,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD8'
  },
  corruptionraid6target: {
    color: '103,2,0',
    com: 'ALT-SHIFT-INSERT'
  },
  sbL1raid2target: {
    color: '128,7,0',
    com: 'ALT-;'
  },
  agonyraid17target: {
    color: '254,4,0',
    com: 'SHIFT-NUMPAD8'
  },
  sbL1focus: {
    color: '85,8,0',
    com: 'ALT-CTRL-.'
  },
  burst1drainSoul: {
    color: '234,1,0',
    com: 'ALT-CTRL-SHIFT-F5'
  },
  corruptionraid2target: {
    color: '76,2,0',
    com: 'ALT-INSERT'
  },
  burst3drainSoul: {
    color: '7,2,0',
    com: 'ALT-CTRL-SHIFT-F7'
  },
  focusLivingEmber: {
    color: '174,0,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD0'
  },
  sbraid8target: {
    color: '143,6,0',
    com: 'CTRL-DOWN'
  },
  agonyraid15target: {
    color: '156,4,0',
    com: 'CTRL-NUMPAD8'
  },
  drainSoulraid12target: {
    color: '189,5,0',
    com: 'ALT-CTRL-NUMPADMINUS'
  },
  unAffparty3target: {
    color: '87,4,0',
    com: 'ALT-CTRL-SHIFT-N'
  },
  sbL1raid3target: {
    color: '22,7,0',
    com: 'SHIFT-;'
  },
  drainSoulraid10target: {
    color: '205,5,0',
    com: 'SHIFT-NUMPADMINUS'
  },
  tarEnemy: {
    color: '161,0,0',
    com: 'ALT-CTRL-NUMPAD0'
  },
  sbraid24target: {
    color: '13,7,0',
    com: 'SHIFT-RIGHT'
  },
  doommouseover: {
    color: '165,1,0',
    com: 'ALT-CTRL-SHIFT-F4'
  },
  eqSetSp: {
    color: '105,8,0',
    com: 'ALT-CTRL-F10'
  },
  sbL1raid10target: {
    color: '85,7,0',
    com: "SHIFT-'"
  },
  corruptionparty1target: {
    color: '5,3,0',
    com: 'CTRL-N'
  },
  sbL1raid20target: {
    color: '229,7,0',
    com: 'ALT-SHIFT-,'
  },
  agonyraid24target: {
    color: '42,5,0',
    com: 'SHIFT-NUMPAD9'
  },
  sbraid2target: {
    color: '134,6,0',
    com: 'ALT-UP'
  },
  sbL1raid18target: {
    color: '245,7,0',
    com: 'CTRL-SHIFT-,'
  },
  unAffraid3target: {
    color: '71,3,0',
    com: 'SHIFT-PAGEUP'
  },
  unAffraid4target: {
    color: '149,3,0',
    com: 'CTRL-SHIFT-PAGEUP'
  },
  burst3corruption: {
    color: '54,2,0',
    com: 'ALT-F7'
  },
  conflagrate: {
    color: '43,1,0',
    com: 'ALT-SHIFT-F2'
  },
  unAfffocus: {
    color: '255,3,0',
    com: 'ALT-CTRL-]'
  },
  corruptionraid22target: {
    color: '74,3,0',
    com: 'CTRL-END'
  },
  shoot: {
    color: '83,0,0',
    com: 'SHIFT-F10'
  },
  sbraid11target: {
    color: '103,6,0',
    com: 'CTRL-SHIFT-DOWN'
  },
  unAffraid8target: {
    color: '186,3,0',
    com: 'CTRL-PAGEDOWN'
  },
  unAffraid6target: {
    color: '96,3,0',
    com: 'ALT-SHIFT-PAGEUP'
  },
  unAffraid1target: {
    color: '143,3,0',
    com: 'CTRL-PAGEUP'
  },
  corruptionraid23target: {
    color: '235,2,0',
    com: 'ALT-END'
  },
  agony: {
    color: '230,0,0',
    com: 'ALT-CTRL-F1'
  },
  corruptionraid17target: {
    color: '11,3,0',
    com: 'SHIFT-HOME'
  },
  sbL1raid12target: {
    color: '163,7,0',
    com: "ALT-CTRL-'"
  },
  corruptionraid1target: {
    color: '161,2,0',
    com: 'CTRL-INSERT'
  },
  burst2drainSoul: {
    color: '250,1,0',
    com: 'ALT-CTRL-SHIFT-F6'
  },
  unAffparty4target: {
    color: '100,4,0',
    com: 'CTRL-L'
  },
  sbraid20target: {
    color: '246,6,0',
    com: 'ALT-SHIFT-LEFT'
  },
  unAffraid14target: {
    color: '5,4,0',
    com: 'ALT-CTRL-SHIFT-PAGEDOWN'
  },
  corruption: {
    color: '8,1,0',
    com: 'SHIFT-F1'
  },
  unAffraid21target: {
    color: '31,4,0',
    com: 'ALT-CTRL-SHIFT-['
  },
  agonyraid4target: {
    color: '137,4,0',
    com: 'CTRL-SHIFT-NUMPAD6'
  },
  burst1haunt: {
    color: '221,1,0',
    com: 'CTRL-SHIFT-F5'
  },
  tarBoss2: {
    color: '63,0,0',
    com: 'ALT-NUMPAD0'
  },
  burst1lifeTap: {
    color: '210,1,0',
    com: 'ALT-SHIFT-F5'
  },
  sbraid7target: {
    color: '87,6,0',
    com: 'ALT-CTRL-SHIFT-UP'
  },
  agonyraid25target: {
    color: '51,5,0',
    com: 'CTRL-SHIFT-NUMPAD9'
  },
  clearMirror: {
    color: '145,0,0',
    com: 'CTRL-SHIFT-NUMPAD0'
  },
  sbparty2target: {
    color: '212,6,0',
    com: 'ALT-7'
  },
  sbparty3target: {
    color: '54,7,0',
    com: 'SHIFT-7'
  },
  shadowfury: {
    color: '3,1,0',
    com: 'ALT-SHIFT-F8'
  },
  corruptionraid20target: {
    color: '254,2,0',
    com: 'ALT-SHIFT-HOME'
  },
  sbL1raid15target: {
    color: '123,7,0',
    com: 'CTRL-,'
  },
  drainSoulraid18target: {
    color: '5,6,0',
    com: 'CTRL-SHIFT-NUMPADMULTIPLY'
  },
  sbraid15target: {
    color: '127,6,0',
    com: 'CTRL-LEFT'
  },
  unAffraid15target: {
    color: '152,3,0',
    com: 'CTRL-['
  },
  agonyraid23target: {
    color: '206,4,0',
    com: 'ALT-NUMPAD9'
  },
  agonyraid10target: {
    color: '116,4,0',
    com: 'SHIFT-NUMPAD7'
  },
  lifeTap: {
    color: '158,0,0',
    com: 'ALT-CTRL-SHIFT-F1'
  },
  focusXe321: {
    color: '190,0,0',
    com: 'SHIFT-NUMPAD1'
  },
  sbraid13target: {
    color: '203,6,0',
    com: 'ALT-SHIFT-DOWN'
  },
  corruptionparty3target: {
    color: '83,3,0',
    com: 'SHIFT-N'
  },
  agonyraid14target: {
    color: '241,4,0',
    com: 'ALT-CTRL-SHIFT-NUMPAD7'
  },
  burst2unAff: {
    color: '238,1,0',
    com: 'SHIFT-F6'
  },
  corruptionparty2target: {
    color: '27,3,0',
    com: 'ALT-N'
  },
  sbL1raid9target: {
    color: '160,7,0',
    com: "ALT-'"
  },
  stopCasting: {
    color: '98,8,0',
    com: 'CTRL-F9'
  },
  agonyraid13target: {
    color: '225,4,0',
    com: 'ALT-SHIFT-NUMPAD7'
  },
  unAffraid7target: {
    color: '123,3,0',
    com: 'ALT-CTRL-SHIFT-PAGEUP'
  },
  shadowWard: {
    color: '92,2,0',
    com: 'SHIFT-F8'
  },
  sbparty1target: {
    color: '65,7,0',
    com: 'CTRL-7'
  },
  sbL1raid17target: {
    color: '223,7,0',
    com: 'SHIFT-,'
  },
  sbraid5target: {
    color: '140,6,0',
    com: 'ALT-CTRL-UP'
  },
  corruptionraid18target: {
    color: '48,3,0',
    com: 'CTRL-SHIFT-HOME'
  },
  sbraid18target: {
    color: '131,6,0',
    com: 'CTRL-SHIFT-LEFT'
  },
  drainSoulparty3target: {
    color: '62,6,0',
    com: 'ALT-CTRL-SHIFT-M'
  },
  sbL1raid25target: {
    color: '29,8,0',
    com: 'CTRL-SHIFT-.'
  },
  corruptionfocus: {
    color: '140,3,0',
    com: 'ALT-CTRL-END'
  },
  sbraid6target: {
    color: '65,6,0',
    com: 'ALT-SHIFT-UP'
  },
  drainSoulraid20target: {
    color: '249,5,0',
    com: 'ALT-SHIFT-NUMPADMULTIPLY'
  },
  corruptionraid11target: {
    color: '132,2,0',
    com: 'CTRL-SHIFT-DELETE'
  },
  burst1: {
    color: '36,8,0',
    com: 'ALT-F9'
  },
  corruptionraid14target: {
    color: '172,2,0',
    com: 'ALT-CTRL-SHIFT-DELETE'
  },
  lifeTapL4: {
    color: '129,2,0',
    com: 'SHIFT-K'
  },
  incinerate: {
    color: '243,0,0',
    com: 'ALT-CTRL-F2'
  },
  sbL1raid22target: {
    color: '176,7,0',
    com: 'CTRL-.'
  },
  sbraid17target: {
    color: '241,6,0',
    com: 'SHIFT-LEFT'
  },
  burst3agony: {
    color: '60,2,0',
    com: 'ALT-CTRL-F7'
  },
  drainSoulraid23target: {
    color: '192,5,0',
    com: 'ALT-NUMPADDIVIDE'
  },
  agonyraid12target: {
    color: '163,4,0',
    com: 'ALT-CTRL-NUMPAD7'
  },
  tarBoss3: {
    color: '126,0,0',
    com: 'SHIFT-NUMPAD0'
  },
  drainSoulraid2target: {
    color: '45,5,0',
    com: 'ALT-NUMPADPLUS'
  },
  seedfocus: {
    color: '146,1,0',
    com: 'ALT-CTRL-F4'
  },
  sear: {
    color: '100,1,0',
    com: 'CTRL-F3'
  },
  drainSoulraid19target: {
    color: '157,5,0',
    com: 'ALT-CTRL-NUMPADMULTIPLY'
  },
  burst3lifeTap: {
    color: '241,1,0',
    com: 'ALT-SHIFT-F7'
  },
  tarFlyGhost: {
    color: '92,0,0',
    com: 'ALT-NUMPAD1'
  },
  burst2haunt: {
    color: '247,1,0',
    com: 'CTRL-SHIFT-F6'
  },
  clearFocus: {
    color: '76,0,0',
    com: 'CTRL-MOUSEWHEELDOWN'
  },
  agonyraid11target: {
    color: '143,4,0',
    com: 'CTRL-SHIFT-NUMPAD7'
  },
  unAffraid20target: {
    color: '22,4,0',
    com: 'ALT-SHIFT-NUMPAD5'
  },
  sbL1raid21target: {
    color: '220,7,0',
    com: 'ALT-CTRL-SHIFT-,'
  },
  tarDark: {
    color: '152,0,0',
    com: 'ALT-SHIFT-NUMPAD1'
  },
  burst1agony: {
    color: '109,1,0',
    com: 'ALT-CTRL-F5'
  },
  corruptionraid8target: {
    color: '189,2,0',
    com: 'CTRL-DELETE'
  },
  unAffraid2target: {
    color: '43,3,0',
    com: 'ALT-PAGEUP'
  },
  unAffraid9target: {
    color: '165,3,0',
    com: 'ALT-PAGEDOWN'
  },
  corruptionraid3target: {
    color: '63,2,0',
    com: 'SHIFT-INSERT'
  },
  unAffraid24target: {
    color: '34,4,0',
    com: 'SHIFT-]'
  },
  sbL1raid7target: {
    color: '59,7,0',
    com: 'ALT-CTRL-SHIFT-;'
  },
  agonyparty2target: {
    color: '238,4,0',
    com: 'ALT-M'
  },
  burst2corruption: {
    color: '172,1,0',
    com: 'ALT-F6'
  },
  sbparty4target: {
    color: '78,7,0',
    com: 'CTRL-SHIFT-7'
  },
  unAffraid18target: {
    color: '192,3,0',
    com: 'CTRL-SHIFT-['
  },
  corruptionraid4target: {
    color: '166,2,0',
    com: 'CTRL-SHIFT-INSERT'
  },
  corruptionraid19target: {
    color: '198,2,0',
    com: 'ALT-CTRL-HOME'
  },
  agonyraid8target: {
    color: '169,4,0',
    com: 'CTRL-NUMPAD7'
  },
  drainSoulraid6target: {
    color: '180,5,0',
    com: 'ALT-SHIFT-NUMPADPLUS'
  }
};
const config = Object.keys(data).reduce((acc, key) => {
  if (data[key].com) {
    const color = data[key].color.split(',').map(Number);
    const hex = rgbToHex(color[0], color[1], color[2]);
    acc[hex] = data[key].com;
  }
  return acc;
}, {} as Record<string, string>);

export const color_mappings: Record<string, string> = {
  '#100800': 'tab',
  '#f10200': 'SHIFT-DELETE',
  '#390000': 'CTRL-F10',
  '#ac0400': 'ALT-CTRL-NUMPAD8',
  '#6b0700': "ALT-CTRL-SHIFT-'",
  '#380100': 'SHIFT-F4',
  '#280100': 'SHIFT-F2',
  '#700100': 'CTRL-F6',
  '#190500': 'CTRL-SHIFT-NUMPAD8',
  '#220100': 'ALT-CTRL-SHIFT-F2',
  '#d10300': 'ALT-CTRL-PAGEDOWN',
  '#530500': 'ALT-CTRL-SHIFT-NUMPADPLUS',
  '#3f0400': 'SHIFT-NUMPAD6',
  '#cd0300': 'ALT-[',
  '#930700': "CTRL-'",
  '#dd0300': 'SHIFT-PAGEDOWN',
  '#d80700': 'ALT-SHIFT-7',
  '#0e0500': 'ALT-SHIFT-NUMPAD8',
  '#600100': 'CTRL-F5',
  '#6f0500': 'CTRL-SHIFT-NUMPADMINUS',
  '#840400': 'CTRL-NUMPAD6',
  '#b50300': 'ALT-CTRL-PAGEUP',
  '#330200': 'ALT-K',
  '#1f0100': 'ALT-SHIFT-F3',
  '#2d0800': 'ALT-CTRL-7',
  '#880500': 'ALT-CTRL-SHIFT-NUMPADMINUS',
  '#020300': 'ALT-HOME',
  '#c00700': "ALT-SHIFT-'",
  '#b10600': 'ALT-CTRL-DOWN',
  '#440400': 'CTRL-]',
  '#e10600': 'ALT-CTRL-SHIFT-DOWN',
  '#2d0600': 'ALT-L',
  '#980500': 'ALT-CTRL-NUMPADPLUS',
  '#e20500': 'ALT-NUMPADMULTIPLY',
  '#720600': 'CTRL-UP',
  '#360500': 'SHIFT-M',
  '#4f0800': 'ALT-F10',
  '#240000': 'CTRL-NUMPAD0',
  '#ea0300': 'ALT-SHIFT-PAGEDOWN',
  '#cb0700': 'ALT-.',
  '#e80500': 'ALT-CTRL-M',
  '#5e0500': 'CTRL-SHIFT-M',
  '#ac0600': 'ALT-DOWN',
  '#9a0700': 'ALT-SHIFT-;',
  '#170000': 'ALT-CTRL-SHIFT-F9',
  '#a00400': 'ALT-NUMPAD6',
  '#120600': 'ALT-CTRL-SHIFT-NUMPADMULTIPLY',
  '#d40300': 'ALT-CTRL-[',
  '#8d0100': 'CTRL-F4',
  '#dd0500': 'ALT-SHIFT-NUMPADMINUS',
  '#b70600': 'ALT-CTRL-LEFT',
  '#7d0100': 'ALT-CTRL-F3',
  '#1c0200': 'ALT-CTRL-F6',
  '#430500': 'SHIFT-NUMPADPLUS',
  '#3a0800': 'SHIFT-L',
  '#580500': 'CTRL-NUMPADPLUS',
  '#6f0800': 'CTRL-SHIFT-F9',
  '#880300': 'CTRL-SHIFT-PAGEDOWN',
  '#7b0500': 'CTRL-SHIFT-NUMPADPLUS',
  '#fa0300': 'ALT-SHIFT-N',
  '#360300': 'ALT-CTRL-SHIFT-HOME',
  '#d60200': 'ALT-DELETE',
  '#c20100': 'SHIFT-F5',
  '#190700': 'CTRL-RIGHT',
  '#c90000': 'CTRL-NUMPAD1',
  '#d70100': 'SHIFT-F7',
  '#5e0700': 'CTRL-SHIFT-;',
  '#210800': 'ALT-SHIFT-F9',
  '#2a0800': 'ALT-CTRL-F9',
  '#e60200': 'ALT-CTRL-DELETE',
  '#da0300': 'ALT-]',
  '#d10600': 'ALT-LEFT',
  '#da0000': 'CTRL-F1',
  '#4a0400': 'CTRL-SHIFT-]',
  '#520700': "CTRL-SHIFT-'",
  '#220600': 'SHIFT-NUMPADDIVIDE',
  '#860700': 'ALT-CTRL-;',
  '#c30000': 'CTRL-F2',
  '#430300': 'SHIFT-END',
  '#0e0100': 'ALT-SHIFT-F1',
  '#700300': 'CTRL-SHIFT-N',
  '#660800': 'SHIFT-F9',
  '#1b0100': 'ALT-F2',
  '#950000': 'CTRL-SHIFT-F1',
  '#840000': 'ALT-CTRL-NUMPAD1',
  '#c40600': 'ALT-RIGHT',
  '#c90200': 'ALT-SHIFT-DELETE',
  '#b20100': 'ALT-SHIFT-F6',
  '#910200': 'CTRL-K',
  '#f50500': 'SHIFT-NUMPADMULTIPLY',
  '#5b0700': 'CTRL-;',
  '#a30500': 'CTRL-NUMPADMULTIPLY',
  '#e50400': 'ALT-NUMPAD8',
  '#050800': 'ALT-CTRL-SHIFT-7',
  '#0a0800': 'SHIFT-.',
  '#190400': 'ALT-CTRL-NUMPAD6',
  '#120400': 'SHIFT-[',
  '#970700': 'ALT-CTRL-,',
  '#5b0400': 'ALT-CTRL-SHIFT-NUMPAD6',
  '#500000': 'ALT-CTRL-SHIFT-F10',
  '#980100': 'CTRL-F7',
  '#170200': 'ALT-CTRL-F8',
  '#530100': 'CTRL-SHIFT-F4',
  '#fc0500': 'ALT-SHIFT-M',
  '#c90400': 'ALT-NUMPAD7',
  '#470600': 'CTRL-SHIFT-UP',
  '#b00500': 'CTRL-NUMPADDIVIDE',
  '#780500': 'CTRL-NUMPADMINUS',
  '#3a0600': 'CTRL-SHIFT-NUMPADDIVIDE',
  '#4d0100': 'SHIFT-F3',
  '#6c0600': 'ALT-CTRL-NUMPADDIVIDE',
  '#480100': 'ALT-CTRL-SHIFT-F3',
  '#790000': 'ALT-SHIFT-NUMPAD0',
  '#500300': 'CTRL-SHIFT-END',
  '#090700': 'ALT-CTRL-SHIFT-LEFT',
  '#d40400': 'CTRL-NUMPAD9',
  '#a90100': 'ALT-F5',
  '#5e0400': 'ALT-CTRL-N',
  '#c50700': 'ALT-,',
  '#b90400': 'ALT-SHIFT-NUMPAD6',
  '#e30000': 'ALT-F1',
  '#720500': 'ALT-CTRL-NUMPAD9',
  '#270600': 'SHIFT-UP',
  '#c80600': 'SHIFT-DOWN',
  '#fc0600': 'ALT-CTRL-RIGHT',
  '#2f0200': 'CTRL-SHIFT-F7',
  '#e80400': 'CTRL-M',
  '#670100': 'CTRL-SHIFT-F3',
  '#b50100': 'CTRL-F8',
  '#9c0600': 'CTRL-SHIFT-RIGHT',
  '#b90200': 'ALT-CTRL-INSERT',
  '#b70500': 'ALT-NUMPADMINUS',
  '#740200': 'ALT-CTRL-SHIFT-INSERT',
  '#590000': 'ALT-SHIFT-F10',
  '#dd0000': 'CTRL-SHIFT-F2',
  '#c00200': 'CTRL-HOME',
  '#260500': 'ALT-CTRL-SHIFT-NUMPAD8',
  '#670200': 'ALT-SHIFT-INSERT',
  '#800700': 'ALT-;',
  '#fe0400': 'SHIFT-NUMPAD8',
  '#550800': 'ALT-CTRL-.',
  '#ea0100': 'ALT-CTRL-SHIFT-F5',
  '#4c0200': 'ALT-INSERT',
  '#070200': 'ALT-CTRL-SHIFT-F7',
  '#ae0000': 'ALT-CTRL-SHIFT-NUMPAD0',
  '#8f0600': 'CTRL-DOWN',
  '#9c0400': 'CTRL-NUMPAD8',
  '#bd0500': 'ALT-CTRL-NUMPADMINUS',
  '#570400': 'ALT-CTRL-SHIFT-N',
  '#160700': 'SHIFT-;',
  '#cd0500': 'SHIFT-NUMPADMINUS',
  '#a10000': 'ALT-CTRL-NUMPAD0',
  '#0d0700': 'SHIFT-RIGHT',
  '#a50100': 'ALT-CTRL-SHIFT-F4',
  '#690800': 'ALT-CTRL-F10',
  '#550700': "SHIFT-'",
  '#050300': 'CTRL-N',
  '#e50700': 'ALT-SHIFT-,',
  '#2a0500': 'SHIFT-NUMPAD9',
  '#860600': 'ALT-UP',
  '#f50700': 'CTRL-SHIFT-,',
  '#470300': 'SHIFT-PAGEUP',
  '#950300': 'CTRL-SHIFT-PAGEUP',
  '#360200': 'ALT-F7',
  '#2b0100': 'ALT-SHIFT-F2',
  '#ff0300': 'ALT-CTRL-]',
  '#4a0300': 'CTRL-END',
  '#530000': 'SHIFT-F10',
  '#670600': 'CTRL-SHIFT-DOWN',
  '#ba0300': 'CTRL-PAGEDOWN',
  '#600300': 'ALT-SHIFT-PAGEUP',
  '#8f0300': 'CTRL-PAGEUP',
  '#eb0200': 'ALT-END',
  '#e60000': 'ALT-CTRL-F1',
  '#0b0300': 'SHIFT-HOME',
  '#a30700': "ALT-CTRL-'",
  '#a10200': 'CTRL-INSERT',
  '#fa0100': 'ALT-CTRL-SHIFT-F6',
  '#640400': 'CTRL-L',
  '#f60600': 'ALT-SHIFT-LEFT',
  '#050400': 'ALT-CTRL-SHIFT-PAGEDOWN',
  '#080100': 'SHIFT-F1',
  '#1f0400': 'ALT-CTRL-SHIFT-[',
  '#890400': 'CTRL-SHIFT-NUMPAD6',
  '#dd0100': 'CTRL-SHIFT-F5',
  '#3f0000': 'ALT-NUMPAD0',
  '#d20100': 'ALT-SHIFT-F5',
  '#570600': 'ALT-CTRL-SHIFT-UP',
  '#330500': 'CTRL-SHIFT-NUMPAD9',
  '#910000': 'CTRL-SHIFT-NUMPAD0',
  '#d40600': 'ALT-7',
  '#360700': 'SHIFT-7',
  '#030100': 'ALT-SHIFT-F8',
  '#fe0200': 'ALT-SHIFT-HOME',
  '#7b0700': 'CTRL-,',
  '#050600': 'CTRL-SHIFT-NUMPADMULTIPLY',
  '#7f0600': 'CTRL-LEFT',
  '#980300': 'CTRL-[',
  '#ce0400': 'ALT-NUMPAD9',
  '#740400': 'SHIFT-NUMPAD7',
  '#9e0000': 'ALT-CTRL-SHIFT-F1',
  '#be0000': 'SHIFT-NUMPAD1',
  '#cb0600': 'ALT-SHIFT-DOWN',
  '#530300': 'SHIFT-N',
  '#f10400': 'ALT-CTRL-SHIFT-NUMPAD7',
  '#ee0100': 'SHIFT-F6',
  '#1b0300': 'ALT-N',
  '#a00700': "ALT-'",
  '#620800': 'CTRL-F9',
  '#e10400': 'ALT-SHIFT-NUMPAD7',
  '#7b0300': 'ALT-CTRL-SHIFT-PAGEUP',
  '#5c0200': 'SHIFT-F8',
  '#410700': 'CTRL-7',
  '#df0700': 'SHIFT-,',
  '#8c0600': 'ALT-CTRL-UP',
  '#300300': 'CTRL-SHIFT-HOME',
  '#830600': 'CTRL-SHIFT-LEFT',
  '#3e0600': 'ALT-CTRL-SHIFT-M',
  '#1d0800': 'CTRL-SHIFT-.',
  '#8c0300': 'ALT-CTRL-END',
  '#410600': 'ALT-SHIFT-UP',
  '#f90500': 'ALT-SHIFT-NUMPADMULTIPLY',
  '#840200': 'CTRL-SHIFT-DELETE',
  '#240800': 'ALT-F9',
  '#ac0200': 'ALT-CTRL-SHIFT-DELETE',
  '#810200': 'SHIFT-K',
  '#f30000': 'ALT-CTRL-F2',
  '#b00700': 'CTRL-.',
  '#f10600': 'SHIFT-LEFT',
  '#3c0200': 'ALT-CTRL-F7',
  '#c00500': 'ALT-NUMPADDIVIDE',
  '#a30400': 'ALT-CTRL-NUMPAD7',
  '#7e0000': 'SHIFT-NUMPAD0',
  '#2d0500': 'ALT-NUMPADPLUS',
  '#920100': 'ALT-CTRL-F4',
  '#640100': 'CTRL-F3',
  '#9d0500': 'ALT-CTRL-NUMPADMULTIPLY',
  '#f10100': 'ALT-SHIFT-F7',
  '#5c0000': 'ALT-NUMPAD1',
  '#f70100': 'CTRL-SHIFT-F6',
  '#4c0000': 'CTRL-MOUSEWHEELDOWN',
  '#8f0400': 'CTRL-SHIFT-NUMPAD7',
  '#160400': 'ALT-SHIFT-NUMPAD5',
  '#dc0700': 'ALT-CTRL-SHIFT-,',
  '#980000': 'ALT-SHIFT-NUMPAD1',
  '#6d0100': 'ALT-CTRL-F5',
  '#bd0200': 'CTRL-DELETE',
  '#2b0300': 'ALT-PAGEUP',
  '#a50300': 'ALT-PAGEDOWN',
  '#3f0200': 'SHIFT-INSERT',
  '#220400': 'SHIFT-]',
  '#3b0700': 'ALT-CTRL-SHIFT-;',
  '#ee0400': 'ALT-M',
  '#ac0100': 'ALT-F6',
  '#4e0700': 'CTRL-SHIFT-7',
  '#c00300': 'CTRL-SHIFT-[',
  '#a60200': 'CTRL-SHIFT-INSERT',
  '#c60200': 'ALT-CTRL-HOME',
  '#a90400': 'CTRL-NUMPAD7',
  '#b40500': 'ALT-SHIFT-NUMPADPLUS'
};
