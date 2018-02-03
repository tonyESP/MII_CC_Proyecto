module.exports = function(mongoose){
    return [{
    name: {type: String, required: true},
    description: {type: String},
    //uniqueId: { type: String, required: true, index: true, unique: true},
    latitud: {type: String},
    longitud: {type: String}
    }, {
        timestamps: true,
        createdby: true,
        updatedby: true
    }]
};
