const result = data
.split('\n')
.filter( e => e)
.map(parseFloat)
.reduce(addNumbersReducer);
