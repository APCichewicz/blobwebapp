// get the span element with id visitor-count
const visitorCountSpan = document.getElementById("visitor-count");

// function to run on pageload
fetch("https://crc-function-app-01.azurewebsites.net/api/ResumeHttpTrigger?")
  .then((res) => res.json())
  .then((res) => {
    visitorCountSpan.innerHTML = res;
  })
  .catch((err) => {
    console.log(err);
  });
