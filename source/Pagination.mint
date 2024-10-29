/* A component for displaying buttons for paginatable content. */
component Ui.Pagination {
  connect Ui exposing { mobile }

  /* The change event handler. */
  property onChange : Function(Number, Promise(Void)) = Promise.never1

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* Whether or not the pagination is disabled. */
  property disabled : Bool = false

  /* How many side pages to render. */
  property sidePages : Number = 2

  /* How many items are in one page. */
  property perPage : Number = 10

  /* The total number of items. */
  property total : Number = 0

  /* The current page. */
  property page : Number = 0

  /* Style for the base element. */
  style base {
    font-size: #{Ui.Size.toString(size)};
    width: min-content;
  }

  /* Style for the ellipsis between the buttons. */
  style ellipsis {
    white-space: nowrap;

    align-items: center;
    display: grid;

    &:before {
      content: "\\2219 \\2219 \\2219";
    }
  }

  /* Style for the mobile page indicator. */
  style mobile-indicator {
    align-items: center;
    display: grid;

    white-space: nowrap;
    font-weight: bold;
  }

  /* Renders a button. */
  fun renderButton (data : Tuple(Number, Bool, String, Html)) : Html {
    let {page, active, label, icon} =
      data

    let type =
      if active {
        "primary"
      } else {
        "faded"
      }

    let key =
      Number.toString(page) + label

    <Ui.Button
      onClick={(event : Html.Event) { onChange(page) }}
      disabled={disabled}
      iconBefore={icon}
      ellipsis={false}
      label={label}
      type={type}
      key={key}
    />
  }

  /* Renders the pagination. */
  fun render : Html {
    let pages =
      Math.floor(Math.max(total - 1, 0) / perPage)

    let buttonRange =
      Array.range(Math.max(0, page - sidePages),
        Math.min(page + sidePages, pages))

    <div::base>
      <Ui.Container gap={Ui.Size.Em(0.625)} justify="start" align="stretch">
        /* First page button */
        if !mobile && !Array.contains(buttonRange, 0) {
          renderButton({0, false, "", Ui.Icons.DOUBLE_CHEVRON_LEFT})
        }

        /* Previous button */
        if page > 0 {
          renderButton({page - 1, false, "", Ui.Icons.CHEVRON_LEFT})
        }

        /* Left ellipsis */
        if !mobile && sidePages < (page - 1) && pages > 0 {
          <span::ellipsis/>
        }

        if mobile {
          if page != pages {
            [
              <div::mobile-indicator>
                Number.toString(page + 1)
                " of "
                Number.toString(pages + 1)
              </div>
            ]
          } else {
            []
          }
        } else {
          for index of buttonRange {
            renderButton(
              {index, index == page, Number.toString(index + 1), <></>})
          }
        }

        /* Right ellipsis */
        if !mobile && (page + sidePages + 1 < pages) && pages > 0 {
          <span::ellipsis/>
        }

        /* Next page button */
        if page < pages && pages > 0 {
          renderButton({page + 1, false, "", Ui.Icons.CHEVRON_RIGHT})
        }

        /* Last page button */
        if !mobile && page < pages && !Array.contains(buttonRange, pages) {
          renderButton({pages, false, "", Ui.Icons.DOUBLE_CHEVRON_RIGHT})
        }
      </Ui.Container>
    </div>
  }
}
