$ ->
    $("#select-dataset").select2()
    $("#select-dataset-plots").select2()
    $("#select-dataset").on "change", ->
        window.show_image this.value
        $("#select-dataset-plots").value = this.value

    $("#select-dataset-plots").on "change", ->
        window.show_plots this.value
        $("#select-dataset").value = this.value

    window.show_image $("#select-dataset").val()
    window.show_plots $("#select-dataset").val()
