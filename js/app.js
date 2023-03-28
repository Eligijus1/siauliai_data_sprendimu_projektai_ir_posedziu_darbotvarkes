const handleRow = function (event, entry) {
    window.open(entry.fileName, "_blank");
};

const vueFramework = new Vue({
    el: '#app',
    components: {
        VueBootstrapTable: VueBootstrapTable
    },
    data: {
        logging: [],
        showFilter: true,
        showPicker: false,
        showSelect: false,
        paginated: false,
        multiColumnSortable: true,
        columnToSortBy: "date",
        handleRowFunction: handleRow,
        ajax: {
            enabled: false,
            url: "",
            method: "POST",
            delegate: true,
        },
        columns: [
            {
                title: "Laikas",
                name: "date",
                visible: true,
                editable: false,
            },
            {
                title: "Pavadinimas",
                name: "name",
                visible: true,
                editable: false,
            },
            {
                title: "fileName",
                name: "fileName",
                visible: false,
                editable: false,
            }
        ],
        values: []
    },
    created: function () {
        let self = this;
        this.$on('cellDataModifiedEvent',
            function (originalValue, newValue, columnTitle, entry) {
                self.logging.push("cellDataModifiedEvent - Original Value : " + originalValue +
                    " | New Value : " + newValue +
                    " | Column : " + columnTitle +
                    " | Complete Entry : " + entry);
            }
        );
        this.$on('ajaxLoadedEvent',
            function (data) {
                this.logging.push("ajaxLoadedEvent - data : " + data);
            }
        );
        this.$on('ajaxLoadingError',
            function (error) {
                this.logging.push("ajaxLoadingError - error : " + error);
            }
        );
    },
    methods: {
        addItem: function (date, name, fileName) {
            let item = {
                "date": date,
                "name": name,
                "fileName": fileName
            };
            this.values.push(item);
        },
        toggleFilter: function () {
            this.showFilter = !this.showFilter;
        },
        togglePicker: function () {
            this.showPicker = !this.showPicker;
        },
        togglePagination: function () {
            this.paginated = !this.paginated;
        },
        toggleSelect: function () {
            this.showSelect = !this.showSelect;
        }
    },
});

const loadJSON = (callback) => {
    const xObj = new XMLHttpRequest();
    xObj.overrideMimeType("application/json");
    xObj.open('GET', 'data_index.json', true);
    xObj.onreadystatechange = () => {
        if (xObj.readyState === 4 && xObj.status === 200) {
            callback(xObj.responseText);
        }
    };
    xObj.send(null);
}

const init = () => {
    loadJSON((response) => {
        const json = JSON.parse(response);
        let splitValue = [];
        let dateTime = '';
        let fileCaption = '';
        for (const [key, value] of Object.entries(json)) {
            splitValue = `${value}`.split('_');
            dateTime = splitValue[0];
            splitValue.shift();
            fileCaption = splitValue.join(' ');
            fileCaption = fileCaption.split('.').slice(0, -1).join('.');
            fileCaption = fileCaption.replaceAll('darbotvarke', 'darbotvarkė');
            fileCaption = fileCaption.replaceAll('dienotvarke', 'dienotvarkė');
            fileCaption = fileCaption.charAt(0).toUpperCase() + fileCaption.slice(1);
            vueFramework.addItem(dateTime, fileCaption, value);
        }
    });
}

init();
