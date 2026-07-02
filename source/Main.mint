/* Temporary testbed page showcasing all components. */
component Main {
  /* Whether the alert is visible. */
  state alertVisible : Bool = true

  /* The selected radio value. */
  state radioValue : String = "a"

  /* The selected date for the date picker. */
  state dateValue : Time = Time.today()

  /* The selected time for the time picker. */
  state timeValue : Time = Time.now()

  /* The selected datetime for the datetime picker. */
  state datetimeValue : Time = Time.now()

  /* The input value. */
  state inputValue : String = ""

  /* The textarea value. */
  state textareaValue : String = ""

  /* The checkbox value. */
  state checkboxValue : Bool = false

  /* The toggle value. */
  state toggleValue : Bool = false

  /* The slider value. */
  state sliderValue : Number = 50

  /* The select value. */
  state selectValue : String = ""

  /* The native select value. */
  state nativeSelectValue : String = ""

  /* The calendar day. */
  state calendarDay : Time = Time.today()

  /* The calendar month. */
  state calendarMonth : Time = Time.today()

  /* The active tab key. */
  state activeTab : String = "tab1"

  /* Style for the page. */
  style page {
    max-width: 960px;
    margin: 0 auto;
    padding: 2em;
  }

  /* Style for a section. */
  style section {
    margin-bottom: 3em;
  }

  /* Style for a section title. */
  style sectionTitle {
    font-family: var(--font-family);
    color: var(--title-color);
    font-weight: bold;
    font-size: 1.5em;
    line-height: 1.2;

    border-bottom: 0.0625em solid var(--title-border);
    padding-bottom: 0.5em;
    margin-bottom: 1em;
  }

  /* Style for a sub-section title. */
  style subTitle {
    font-family: var(--font-family);
    color: var(--content-text);
    font-weight: bold;
    font-size: 1em;

    margin-bottom: 0.5em;
    margin-top: 1em;
  }

  /* Style for a row of items. */
  style row {
    align-items: center;
    flex-wrap: wrap;
    display: flex;
    gap: 1em;
  }

  /* Style for a column of items. */
  style column {
    display: grid;
    grid-gap: 1em;
  }

  /* Style for a demo box with a max width. */
  style box {
    max-width: 400px;
    width: 100%;
  }

  /* Page title style. */
  style pageTitle {
    font-family: var(--font-family);
    color: var(--title-color);
    font-weight: bold;
    font-size: 2em;
    line-height: 1.2;
    margin-bottom: 0.5em;
  }

  /* Page description style. */
  style pageDescription {
    font-family: var(--font-family);
    color: var(--content-text);
    margin-bottom: 2em;
    line-height: 1.6;
  }

  fun render : Html {
    <Ui.Theme.Root
      fontConfiguration={Ui.DEFAULT_FONT_CONFIGURATION}
      tokens={Ui.DEFAULT_TOKENS}>
      <div::page>
        <div::pageTitle>"Mint UI Component Showcase"</div>

        <div::pageDescription>
          "A testbed page demonstrating all available components."
        </div>

        <div::row style="margin-bottom: 2em;">
          <Ui.DarkModeToggle/>
        </div>

        /* -------------------------------------------------------- */
        /* BUTTONS                                                  */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Button"</div>

          <div::row>
            <Ui.Button label="Primary"/>
            <Ui.Button label="Secondary" type="secondary"/>
            <Ui.Button label="Success" type="success"/>
            <Ui.Button label="Warning" type="warning"/>
            <Ui.Button label="Danger" type="danger"/>
            <Ui.Button label="Faded" type="faded"/>
            <Ui.Button label="Disabled" disabled={true}/>

            <Ui.Button
              label="With Icon"
              iconBefore={Ui.Icons.CHECK}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* INPUT                                                    */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Input"</div>

          <div::box>
            <div::column>
              <Ui.Input
                placeholder="Type something..."
                value={inputValue}
                onChange={(v : String) { next { inputValue: v } }}/>

              <Ui.Input
                placeholder="Disabled"
                disabled={true}/>

              <Ui.Input
                placeholder="Invalid"
                invalid={true}/>

              <Ui.Input
                placeholder="With icon"
                icon={Ui.Icons.SEARCH}/>
            </div>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* TEXTAREA                                                 */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Textarea"</div>

          <div::box>
            <Ui.Textarea
              placeholder="Write something..."
              value={textareaValue}
              onChange={(v : String) { next { textareaValue: v } }}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* CHECKBOX                                                 */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Checkbox"</div>

          <div::row>
            <Ui.Checkbox
              checked={checkboxValue}
              onChange={(v : Bool) { next { checkboxValue: v } }}/>

            <Ui.Checkbox checked={true} disabled={true}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* TOGGLE (SWITCH)                                          */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Toggle"</div>

          <div::row>
            <Ui.Toggle
              checked={toggleValue}
              onChange={(v : Bool) { next { toggleValue: v } }}/>

            <Ui.Toggle checked={true} disabled={true}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* SLIDER                                                   */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Slider"</div>

          <div::box>
            <Ui.Slider
              value={sliderValue}
              onChange={(v : Number) { next { sliderValue: v } }}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* SELECT                                                   */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Select"</div>

          <div::box>
            <div::column>
              <Ui.Select
                items={[
                  Ui.ListItem.Item(
                    matchString: "Apple",
                    content: <>"Apple"</>,
                    key: "apple"),
                  Ui.ListItem.Item(
                    matchString: "Banana",
                    content: <>"Banana"</>,
                    key: "banana"),
                  Ui.ListItem.Item(
                    matchString: "Cherry",
                    content: <>"Cherry"</>,
                    key: "cherry")
                ]}
                onChange={(v : String) { next { selectValue: v } }}
                placeholder="Choose a fruit..."
                value={selectValue}/>

              <Ui.Native.Select
                items={[
                  Ui.ListItem.Item(
                    matchString: "Red",
                    content: <>"Red"</>,
                    key: "red"),
                  Ui.ListItem.Item(
                    matchString: "Green",
                    content: <>"Green"</>,
                    key: "green"),
                  Ui.ListItem.Item(
                    matchString: "Blue",
                    content: <>"Blue"</>,
                    key: "blue")
                ]}
                onChange={(v : String) { next { nativeSelectValue: v } }}
                placeholder="Native select..."
                value={nativeSelectValue}/>
            </div>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* CALENDAR                                                 */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Calendar"</div>

          <Ui.Calendar
            day={calendarDay}
            month={calendarMonth}
            onChange={(v : Time) { next { calendarDay: v } }}
            onMonthChange={(v : Time) { next { calendarMonth: v } }}/>
        </div>

        /* -------------------------------------------------------- */
        /* DATE PICKER                                              */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"DatePicker"</div>

          <div::box>
            <div::column>
              <Ui.DatePicker
                value={dateValue}
                onChange={(v : Time) { next { dateValue: v } }}/>

              <Ui.DatePicker disabled={true}/>
            </div>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* TIME PICKER                                              */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"TimePicker"</div>

          <div::box>
            <div::column>
              <Ui.TimePicker
                value={timeValue}
                onChange={(v : Time) { next { timeValue: v } }}/>

              <Ui.TimePicker disabled={true}/>

              <div::subTitle>"With 15-minute steps"</div>

              <Ui.TimePicker
                value={timeValue}
                onChange={(v : Time) { next { timeValue: v } }}
                step={15}/>
            </div>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* DATETIME PICKER                                          */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"DateTimePicker"</div>

          <div::box>
            <div::column>
              <Ui.DateTimePicker
                value={datetimeValue}
                onChange={(v : Time) { next { datetimeValue: v } }}/>

              <Ui.DateTimePicker disabled={true}/>
            </div>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* FIELD                                                    */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Field"</div>

          <div::box>
            <div::column>
              <Ui.Field label="Username">
                <Ui.Input placeholder="Enter username..."/>
              </Ui.Field>

              <Ui.Field label="Email" error={Maybe.Just("Invalid email address")}>
                <Ui.Input placeholder="Enter email..." invalid={true}/>
              </Ui.Field>
            </div>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* BADGE                                                    */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Badge"</div>

          <div::row>
            <Ui.Badge label="Default"/>

            <Ui.Badge
              label="Success"
              color="var(--success-color)"
              textColor="var(--success-text)"/>

            <Ui.Badge
              label="Warning"
              color="var(--warning-color)"
              textColor="var(--warning-text)"/>

            <Ui.Badge
              label="Danger"
              color="var(--danger-color)"
              textColor="var(--danger-text)"/>

            <Ui.Badge
              label="Secondary"
              color="var(--secondary-color)"
              textColor="var(--secondary-text)"/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* AVATAR                                                   */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Avatar"</div>

          <div::row>
            <Ui.Avatar initials="JD"/>
            <Ui.Avatar initials="AB" circular={false}/>
            <Ui.Avatar/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* TOOLTIP                                                  */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Tooltip"</div>

          <div::row>
            <Ui.Tooltip content="Top tooltip" position={Ui.Position.TopCenter}>
              <Ui.Button label="Hover me (top)"/>
            </Ui.Tooltip>

            <Ui.Tooltip content="Bottom tooltip" position={Ui.Position.BottomCenter}>
              <Ui.Button label="Hover me (bottom)"/>
            </Ui.Tooltip>

            <Ui.Tooltip content="Right tooltip" position={Ui.Position.RightCenter}>
              <Ui.Button label="Hover me (right)"/>
            </Ui.Tooltip>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* ALERT                                                    */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Alert"</div>

          <div::column>
            <Ui.Alert
              level={Ui.Alert.Level.Info}
              title="Information"
              message="This is an informational alert."/>

            <Ui.Alert
              level={Ui.Alert.Level.Success}
              title="Success"
              message="Operation completed successfully."/>

            <Ui.Alert
              level={Ui.Alert.Level.Warning}
              title="Warning"
              message="Please review before proceeding."/>

            <Ui.Alert
              level={Ui.Alert.Level.Danger}
              title="Error"
              message="Something went wrong."
              closeable={true}
              onClose={() { next { alertVisible: true } }}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* RADIO GROUP                                              */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"RadioGroup"</div>

          <div::column>
            <div::subTitle>"Vertical"</div>

            <Ui.RadioGroup
              items={[
                {"a", "Option A"},
                {"b", "Option B"},
                {"c", "Option C"}
              ]}
              value={radioValue}
              onChange={(v : String) { next { radioValue: v } }}/>

            <div::subTitle>"Horizontal"</div>

            <Ui.RadioGroup
              items={[
                {"a", "Small"},
                {"b", "Medium"},
                {"c", "Large"}
              ]}
              value={radioValue}
              onChange={(v : String) { next { radioValue: v } }}
              horizontal={true}/>

            <div::subTitle>"Disabled"</div>

            <Ui.RadioGroup
              items={[{"a", "Disabled option"}]}
              value="a"
              disabled={true}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* ACCORDION                                                */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Accordion"</div>

          <div::column>
            <div::subTitle>"Single mode"</div>

            <Ui.Accordion
              sections={[
                {"s1", "What is Mint UI?", <p>"A comprehensive component library for the Mint programming language."</p>},
                {"s2", "Is it themable?", <p>"Yes! It supports both light and dark modes with CSS custom properties."</p>},
                {"s3", "How do I install it?", <p>"Add it to your mint.json dependencies and run mint install."</p>}
              ]}/>

            <div::subTitle>"Multiple mode"</div>

            <Ui.Accordion
              multiple={true}
              sections={[
                {"m1", "Section One", <p>"Content for section one."</p>},
                {"m2", "Section Two", <p>"Content for section two."</p>}
              ]}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* SEPARATOR                                                */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Separator"</div>

          <div::column>
            <p style="font-family: var(--font-family); color: var(--content-text);">
              "Content above the separator."
            </p>

            <Ui.Separator/>

            <p style="font-family: var(--font-family); color: var(--content-text);">
              "Content below the separator."
            </p>
          </div>

          <div::subTitle>"Vertical"</div>

          <div::row>
            <span style="font-family: var(--font-family); color: var(--content-text);">"Left"</span>
            <Ui.Separator vertical={true}/>
            <span style="font-family: var(--font-family); color: var(--content-text);">"Right"</span>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* SKELETON                                                 */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Skeleton"</div>

          <div::box>
            <div::column>
              <div::row>
                <Ui.Skeleton width="2.5em" height="2.5em" circular={true}/>

                <div style="display: grid; grid-gap: 0.5em; flex: 1;">
                  <Ui.Skeleton width="60%" height="1em"/>
                  <Ui.Skeleton width="40%" height="0.875em"/>
                </div>
              </div>

              <Ui.Skeleton height="8em"/>
              <Ui.Skeleton width="80%" height="1em"/>
              <Ui.Skeleton width="60%" height="1em"/>
            </div>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* CARD                                                     */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Card"</div>

          <div::row>
            <Ui.Card>
              <Ui.Card.Container
                title={<>"Card Title"</>}
                content={<p>"This is the card body content."</p>}/>
            </Ui.Card>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* BREADCRUMBS                                              */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Breadcrumbs"</div>

          <Ui.Breadcrumbs
            items={[
              {"Home", <>"Home"</>},
              {"Components", <>"Components"</>},
              {"Breadcrumbs", <>"Breadcrumbs"</>}
            ]}/>
        </div>

        /* -------------------------------------------------------- */
        /* TABS                                                     */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Tabs"</div>

          <Ui.Tabs
            active={activeTab}
            onChange={(v : String) { next { activeTab: v } }}
            items={[
              {key: "tab1", label: "Tab 1", content: <></>, iconBefore: <></>, iconAfter: <></>},
              {key: "tab2", label: "Tab 2", content: <></>, iconBefore: <></>, iconAfter: <></>},
              {key: "tab3", label: "Tab 3", content: <></>, iconBefore: <></>, iconAfter: <></>}
            ]}/>
        </div>

        /* -------------------------------------------------------- */
        /* TABLE                                                    */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Table"</div>

          <Ui.Table
            headers={[
              {sortKey: "name", sortable: false, label: "Name", shrink: false},
              {sortKey: "role", sortable: false, label: "Role", shrink: false},
              {sortKey: "status", sortable: false, label: "Status", shrink: true}
            ]}
            rows={[
              {"row1", [
                Ui.Cell.String("Alice"),
                Ui.Cell.String("Engineer"),
                Ui.Cell.Html(<Ui.Badge label="Active" color="var(--success-color)" textColor="var(--success-text)"/>)
              ]},
              {"row2", [
                Ui.Cell.String("Bob"),
                Ui.Cell.String("Designer"),
                Ui.Cell.Html(<Ui.Badge label="Inactive" color="var(--secondary-color)" textColor="var(--secondary-text)"/>)
              ]}
            ]}/>
        </div>

        /* -------------------------------------------------------- */
        /* PAGINATION                                               */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Pagination"</div>

          <Ui.Pagination
            page={1}
            total={100}
            perPage={10}
            onChange={Promise.never1}/>
        </div>

        /* -------------------------------------------------------- */
        /* ICON                                                     */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"Icon"</div>

          <div::row>
            <Ui.Icon icon={Ui.Icons.CHECK} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.ALERT} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.INFO} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.CALENDAR} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.CLOCK} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.SEARCH} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.PERSON} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.HEART} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.STAR} size={Ui.Size.Em(1.5)}/>
            <Ui.Icon icon={Ui.Icons.ZAP} size={Ui.Size.Em(1.5)}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* CIRCULAR PROGRESS                                        */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"CircularProgress"</div>

          <div::row>
            <Ui.CircularProgress current={75} size={Ui.Size.Em(4)}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* ILLUSTRATED MESSAGE                                      */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"IllustratedMessage"</div>

          <Ui.IllustratedMessage
            subtitle={<>"Nothing to show right now."</>}
            title={<>"No Data"</>}/>
        </div>

        /* -------------------------------------------------------- */
        /* DARK MODE TOGGLE                                         */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"DarkModeToggle"</div>

          <Ui.DarkModeToggle/>
        </div>

        /* -------------------------------------------------------- */
        /* FILE INPUT                                               */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"FileInput"</div>

          <div::box>
            <Ui.FileInput onChange={(file : Maybe(File)) { next { } }}/>
          </div>
        </div>

        /* -------------------------------------------------------- */
        /* COLOR PICKER                                             */
        /* -------------------------------------------------------- */
        <div::section>
          <div::sectionTitle>"ColorPicker"</div>

          <div::box>
            <Ui.ColorPicker onChange={(color : Color) { next { } }}/>
          </div>
        </div>
      </div>
    </Ui.Theme.Root>
  }
}
