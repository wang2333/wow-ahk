interface PageProps {}

const Page: React.FC<PageProps> = () => {
  return (
    <div>
      <h3>使用说明</h3>
      <p>1. 默认F2为启动按键，F3为暂停按键，F2为佳佳一键宏爆发模式，停到提示音表示生效</p>
      <p>2. F8、F9为取坐标功能，F8为设置X坐标和Y坐标，F9为设置X2坐标和Y坐标</p>
      <p>3. 鼠标移到游戏界面的色块上按下F8、F9，可以自动设置坐标</p>
      <p>4. 热键按下没反应，请按F5刷新软件</p>
    </div>
  );
};

export default Page;
