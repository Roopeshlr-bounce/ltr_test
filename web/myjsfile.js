class Bounce {
	constructor() {

	}
	printName(name) {
		alert(name);
	}

	enablePhonePeLogging() {
		PhonePe.PhonePe.loggingEnabled = true
	}

	fetchToken(token) {
		PhonePe.PhonePe.build(PhonePe.Constants.Species.web).then((sdk) => {
			sdk.fetchAuthToken().then((res) => {
				alert("Grant token data received = " + res)
				alert(res)
				alert(res.grantToken)
				token(res.grantToken)
			}).catch((err) => {
				alert("Error occurred while fetching the grant token: " + err)
				alert(err)
			})
		})
	}


}

var bouncePlugin = new Bounce();