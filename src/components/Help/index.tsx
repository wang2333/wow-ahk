interface PageProps {}

const Page: React.FC<PageProps> = () => {
  return (
    <div className='help-container'>
      <section className='basic-functions'>
        <h3 style={{ margin: '10px' }}>基础功能</h3>
        <ul style={{ margin: 0 }}>
          <li>F1：启动按键</li>
          <li>F2：佳佳一键宏爆发模式，用不到可以绑定空按键不占用热键</li>
          <li>F3：暂停按键</li>
        </ul>
        <p style={{ margin: '5px' }}>听到提示音表示生效</p>
      </section>

      <section className='troubleshooting'>
        <h3 style={{ margin: '10px' }}>常见问题</h3>
        <ul style={{ margin: 0 }}>
          <li>热键无响应：请重启软件</li>
        </ul>
      </section>
    </div>
  );
};

export default Page;
