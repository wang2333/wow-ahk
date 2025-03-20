interface PageProps {}

const Page: React.FC<PageProps> = () => {
  return (
    <div className='help-container'>
      <section className='basic-functions'>
        <h3 style={{ margin: '10px' }}>基础功能</h3>
        <ul style={{ margin: 0 }}>
          <li>F1：启动按键</li>
          <li>F2：佳佳一键宏爆发模式</li>
          <li>F3：暂停按键</li>
        </ul>
        <p style={{ margin: '5px' }}>听到提示音表示生效</p>
      </section>

      <section className='coordinate-functions'>
        <h3 style={{ margin: '10px' }}>坐标设置功能</h3>
        <ul style={{ margin: 0 }}>
          <li>F8：设置X坐标和Y坐标</li>
          <li>F9：设置X2坐标和Y坐标</li>
        </ul>
        <p style={{ margin: '5px' }}>
          操作说明：将鼠标移动到游戏界面的色块上，按下F8或F9即可自动设置对应坐标
        </p>
      </section>

      <section className='troubleshooting'>
        <h3 style={{ margin: '10px' }}>常见问题</h3>
        <ul style={{ margin: 0 }}>
          <li>热键无响应：请按F5刷新软件</li>
          <li>猪猪侠游戏色块在游戏窗口的左上角</li>
          <li>佳佳游戏色块在游戏窗口的左上角和右上角</li>
          <li>小易一键宏的色块已游戏窗口的左上角的第一个色块为准</li>
        </ul>
      </section>
    </div>
  );
};

export default Page;
