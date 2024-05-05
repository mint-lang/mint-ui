component Ui.StickyPanel.Test {
  property position : Ui.Position = Ui.Position.TopLeft

  style base {
    justify-content: center;
    align-items: center;
    display: flex;

    position: absolute;
    height: 500px;
    width: 500px;
    left: 0;
    top: 0;
  }

  style element {
    background: red;
    height: 100px;
    width: 100px;
  }

  style content {
    background: yellow;
    height: 50px;
    width: 50px;
  }

  fun render : Html {
    <div::base id="base">
      <Ui.StickyPanel
        content={<div::content id="content"/>}
        element={<div::element id="element"/>}
        position={position}
        offset={10}/>
    </div>
  }
}

suite "Ui.StickyPanel" {
  test "fills the window correctly" {
    <Ui.StickyPanel.Test/>
    |> Test.Html.start()
    |> Test.Html.find("#base")
    |> Test.Html.assertTop(0)
    |> Test.Html.assertLeft(0)
    |> Test.Html.assertWidth(500)
    |> Test.Html.assertHeight(500)
  }

  test "positions the element correctly" {
    <Ui.StickyPanel.Test/>
    |> Test.Html.start()
    |> Test.Html.find("#element")
    |> Test.Html.assertTop(200)
    |> Test.Html.assertLeft(200)
    |> Test.Html.assertWidth(100)
    |> Test.Html.assertHeight(100)
  }

  test "positions the top-left correctly" {
    <Ui.StickyPanel.Test/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(140)
    |> Test.Html.assertLeft(200)
  }

  test "positions the top-right correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.TopRight}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(140)
    |> Test.Html.assertLeft(250)
  }

  test "positions the top-center correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.TopCenter}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(140)
    |> Test.Html.assertLeft(225)
  }

  test "positions the bottom-left correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.BottomLeft}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(310)
    |> Test.Html.assertLeft(200)
  }

  test "positions the bottom-right correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.BottomRight}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(310)
    |> Test.Html.assertLeft(250)
  }

  test "positions the bottom-center correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.BottomCenter}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(310)
    |> Test.Html.assertLeft(225)
  }

  test "positions the left-top correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.LeftTop}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(200)
    |> Test.Html.assertLeft(140)
  }

  test "positions the left-center correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.LeftCenter}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(225)
    |> Test.Html.assertLeft(140)
  }

  test "positions the left-bottom correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.LeftBottom}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(250)
    |> Test.Html.assertLeft(140)
  }

  test "positions the right-top correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.RightTop}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(200)
    |> Test.Html.assertLeft(310)
  }

  test "positions the right-center correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.RightCenter}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(225)
    |> Test.Html.assertLeft(310)
  }

  test "positions the right-bottom correctly" {
    <Ui.StickyPanel.Test position={Ui.Position.RightBottom}/>
    |> Test.Html.start()
    |> Test.Html.findGlobally("#content")
    |> Test.Html.assertTop(250)
    |> Test.Html.assertLeft(310)
  }
}
