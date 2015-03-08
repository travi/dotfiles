sets =
  hex: "[0-9a-f]"
  byte: "[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]"
  percent: "[0-9]|[1-9][0-9]|100"
  decimal: "0|1\\.?0?|0*\\.\\d+"
  angle: "[+-]?\\d{1,3}"

module.exports = [

  # eg. #fff
  # eg. #ff0000
  new RegExp  "(#(#{sets.hex}{6}|#{sets.hex}{3}))(?=[\\b\\s;]|$)", "i"

  # eg. rgb(0, 125, 255)
  # eg. rgba(255, 125, 0, 0.8)
  new RegExp  "(rgba?\\(" +
                "\\s*(#{sets.byte})\\s*," +
                "\\s*(#{sets.byte})\\s*," +
                "\\s*(#{sets.byte})\\s*" +
                "(,\\s*(#{sets.decimal})\\s*)?" +
              "\\))", "i"

  # eg. rgb(25%, 75%, 100%)
  # eg. rgba(0%, 100%, 25%, .4)
  new RegExp  "(rgba?\\(" +
                "\\s*(#{sets.percent})%\\s*," +
                "\\s*(#{sets.percent})%\\s*," +
                "\\s*(#{sets.percent})%\\s*" +
                "(,\\s*(#{sets.decimal})\\s*)?" +
              "\\))", "i"

  # eg. hsl(120, 100%, 75%)
  # eg. hsla(240, 100%, 50%, 0.7)
  new RegExp  "(hsla?\\(" +
                "\\s*(#{sets.angle})\\s*," +
                "\\s*(#{sets.percent})%\\s*," +
                "\\s*(#{sets.percent})%\\s*" +
                "(,\\s*(#{sets.decimal})\\s*)?" +
              "\\))", "i"

]
