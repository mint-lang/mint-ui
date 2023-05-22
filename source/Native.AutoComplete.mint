/* An auto complete component using the native `datalist` element. */
component Ui.Native.AutoComplete {
  /* The change event handler. */
  property onChange : Function(String, Promise(Void)) = Promise.never1

  /* The size of the input. */
  property size : Ui.Size = Ui.Size::Inherit

  /* The options of the input. */
  property options : Array(String) = []

  /* The placeholder to show when there is no value. */
  property placeholder : String = ""

  /* Whether or not the input is disabled. */
  property disabled : Bool = false

  /* Whether or not the input is invalid. */
  property invalid : Bool = false

  /* The currently selected value. */
  property value : String = ""

  /* The id of the datalist. */
  state id : String = Uid.generate()

  /* Renders the component. */
  fun render : Html {
    <>
      <Ui.Input
        placeholder={placeholder}
        disabled={disabled}
        onChange={onChange}
        invalid={invalid}
        value={value}
        size={size}
        list={id}/>

      <datalist id={id}>
        for option of options {
          <option value={option}/>
        }
      </datalist>
    </>
  }
}
