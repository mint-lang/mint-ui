/* A sortable table component, which collapses into a definition list on small screens. */
component Ui.Table {
  /* The handler for the order change event. */
  property onOrderChange : Function(Tuple(String, String), Promise(Void)) =
    Promise.never1

  /* The data for the rows. */
  property rows : Array(Tuple(String, Array(Ui.Cell))) = []

  /* The data for the headers. */
  property headers : Array(Ui.Table.Header) = []

  /* The size of the component. */
  property size : Ui.Size = Ui.Size.Inherit

  /* The order direction: `asc` or `desc` */
  property orderDirection : String = ""

  /* The breakpoint for the mobile version. */
  property breakpoint : Number = 1000

  /* Whether or not the table has borders. */
  property bordered : Bool = true

  /* The `sortKey` of the column which the content is ordered by. */
  property orderBy : String = ""

  /* A state to hold the width of the component. */
  state width : Number = 0

  /* We are using this provider to update the `width` state. */
  use Provider.ElementSize { changes: updateWidth, element: base }

  /* The style for the table. */
  style base {
    border-collapse: separate;
    border-radius: 0.375em;
    border-spacing: 0;
    width: 100%;

    font-size: #{Ui.Size.toString(size)};
    font-family: var(--font-family);
    line-height: 170%;

    if bordered {
      border: 0.0625em solid var(--input-border);
      background: var(--content-color);
      color: var(--content-text);
    }

    td, th {
      text-align: left;
      padding: 0.5em 0.7em;
    }

    td + td, th + th {
      if bordered {
        border-left: 0.0625em solid var(--input-border);
      }
    }

    tr + tr td {
      border-top: 0.0625em solid var(--input-border);
    }

    th {
      border-bottom: 0.125em solid var(--input-border);

      if bordered {
        background: var(--input-color);
        color: var(--input-text);
      }

      &:first-child {
        border-top-left-radius: 0.375em;
      }

      &:last-child {
        border-top-right-radius: 0.375em;
      }
    }
  }

  /* Returns if we need to use the mobile version or not. */
  get mobile : Bool {
    width < breakpoint
  }

  /* Updates the `width` state based on the dimensions and breakpoint. */
  fun updateWidth (dimensions : Dom.Dimensions) {
    next { width: dimensions.width }
  }

  /* Renders the table. */
  fun render : Html {
    <div as base>
      if mobile {
        <Ui.DefinitionList
          headers={Array.map(headers, .label(Ui.Table.Header))}
          size={size}
          rows={rows}
        />
      } else {
        <table::base as table>
          <thead>
            for header of headers {
              <Ui.Table.Header
                orderDirection={orderDirection}
                onOrderChange={onOrderChange}
                orderBy={orderBy}
                data={header}
              />
            }
          </thead>

          <tbody>
            for row of rows {
              let {summary, cells} =
                row

              <tr>
                for cell of cells {
                  <td><Ui.Cell cell={cell}/></td>
                }
              </tr>
            }
          </tbody>
        </table>
      }
    </div>
  }
}
