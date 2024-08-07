function calculateSum() {
    const number1 = document.getElementById('number1').value;
    const number2 = document.getElementById('number2').value;

    fetch(`/sum?a=${number1}&b=${number2}`)
        .then(response => response.json())
        .then(data => {
            if (data.sum !== undefined) {
                document.getElementById('result').textContent = `Sum: ${data.sum}`;
            } else {
                document.getElementById('result').textContent = 'Error: ' + data.error;
            }
        })
        .catch(error => {
            document.getElementById('result').textContent = 'An error occurred.';
        });
}
