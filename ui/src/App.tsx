import React, { useEffect, useRef, useState } from "react"
import "./App.css"
import "./Site.css"

const devMode = !window?.["invokeNative"]

const App = () => {
	const [theme, setTheme] = useState("light")
	const [site, setSite] = useState("home")
	const [vehicles, setVehicles] = useState<Vehicle[]>([
		{
			model: "XLS",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "T20",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Rhinehart",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Schafter V12",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
		{
			model: "Hakuchou Drag",
			plate: "TEST1233",
			paid: 12500,
			total: 30000,
			totalpayments: 12,
			paidpayments: 5,
			perpayments: 2500,
			open: false,
		},
	])
	const appDiv = useRef(null)

	const {
		setPopUp,
		setContextMenu,
		selectGIF,
		selectGallery,
		selectEmoji,
		fetchNui,
		sendNotification,
		getSettings,
		onSettingsChange,
		colorPicker,
		useCamera
	} = window as any

	useEffect(() => {
		if (devMode) {
			document.getElementsByTagName("html")[0].style.visibility = "visible"
			document.getElementsByTagName("body")[0].style.visibility = "visible"
			return
		} else {
			getSettings().then((settings: any) => setTheme(settings.display.theme))
			onSettingsChange((settings: any) => setTheme(settings.display.theme))
		}
	}, [])
	

	const radius = 50
	const circumference = 2 * radius * Math.PI
	const left = vehicles.reduce((sum, vehicle) => sum + (vehicle.total - vehicle.paid), 0);
	const paid = vehicles.reduce((sum, vehicle) => sum + vehicle.paid, 0); 
	const totalamount = vehicles.reduce((sum, vehicle) => sum + vehicle.total, 0);
	const progress = ((paid / (totalamount)) * circumference)
	const topercent = ((paid / (totalamount)) * 100).toFixed(0)
	const money = left.toLocaleString('en-US')
	const payment = vehicles.reduce((sum, vehicle) => sum + vehicle.perpayments, 0)
	const amount = vehicles.length

	const getProgressColor = (percent: number) => {
		if (percent < 50) {
		  return '#ff0000';
		} else if (percent < 75) {
		  return '#ffbf00';
		} else {
		  return '#10de1a';
		}
	  };

	  const remSize = (text: string) => {
		return Math.min(3*(6 / text.length), 4)
	  }

	const handleOpenVehicle = (index: number) => {
		setVehicles((vehicles) => vehicles.map((vehicle, i) => {
			if (i === index) {
				return { ...vehicle, open: !vehicle.open }
			} else {
				return {...vehicle, open: false}
			}
		}))
	};

	return (
		<AppProvider>
			<div className="app" ref={appDiv} data-theme={theme}>
				<div className="app-wrapper">
					{site === "home" && (
						<>
							<div className="header">
								<div className="title">Financed Vehicles</div>
								<div className="subtitle">JG Dealership</div>
							</div>
							<div className="content">
								<div className="boxes">
									<h1 className="bgt">{amount}</h1>
									<div className="smt">Vehicles financed</div>
								</div>
								<div className="boxes">
									<svg
										width="120"
										height="120"
										className="progress-bar progress-bar--animate"
									>
										<circle
											fill="transparent"
											r="50"
											cx="60"
											cy="60"
											strokeWidth="10"
											className="progress-bar__background"
										/>
										<circle
											stroke={getProgressColor(Number(topercent))}
											fill="transparent"
											r="50"
											cx="60"
											cy="60"
											strokeWidth="10"
											strokeDasharray={circumference}
											strokeDashoffset={circumference - progress}
											className="progress-bar__value"
										/>
									</svg>
									<div
										className="bgt circle"
										style={{ color: getProgressColor(Number(topercent)) }}
									>
										{topercent}%
									</div>
									<div className="smt">{topercent}% debt paid off</div>
								</div>
								<div className="boxes">
									<h1
										className="moneyamount"
										style={{ fontSize: `${remSize(money + "$")}rem` }}
									>
										{money}$
									</h1>
									<div className="smt">Left to be paid</div>
								</div>
								<div className="boxes">
									<h1
										className="moneyamount"
										style={{
											color: "green",
											fontSize: `${remSize(
												payment.toLocaleString("en-US") + "$"
											)}rem`,
										}}
									>
										{payment.toLocaleString("en-US")}$
									</h1>
									<div className="smt">For the next payment (total)</div>
								</div>
							</div>
						</>
					)}
					{site === "vehicles" && (
						<>
							<div className="header top">
								<div className="title">Your Financed Vehicles</div>
							</div>
							<div className="list">
								<div className="listcontents">
									<div className="vehicle">
										<div className="online">
											<div className="vmodel">Vehicle Model</div>
											<div className="remaining">Remaining</div>
										</div>
									</div>
									{vehicles.map((v, index) => (
										<div className="vehicle" key={index}>
											<div className="online">
												<div className="vmodel">{v.model}</div>
												<div className="remaining">{(v.total - v.paid).toLocaleString("en-US")}$</div>
												<button
													className="openmenu"
													onClick={() => handleOpenVehicle(index)}
												>
													...
												</button>
											</div>
											{v.open && (
												<div className="extra">
													<svg
														width="120"
														height="120"
														className="progress-bar progress-bar--animate"
													>
														<circle
															fill="transparent"
															r="50"
															cx="60"
															cy="60"
															strokeWidth="10"
															className="progress-bar__background"
														/>
														<circle
															stroke={getProgressColor(Number(((v.paid / (v.total)) * 100).toFixed(0)))}
															fill="transparent"
															r="50"
															cx="60"
															cy="60"
															strokeWidth="10"
															strokeDasharray={circumference}
															strokeDashoffset={circumference - ((v.paid / (v.total)) * circumference)}
															className="progress-bar__value"
														/>
														<text
															x="50%"
															y="50%"
															textAnchor="middle"
															dominantBaseline="middle"
															className="circlecenter"
															style={{ fill: getProgressColor(Number(((v.paid / (v.total)) * 100).toFixed(0))),}}
														>
															{v.paidpayments} / {v.totalpayments}
														</text>
													</svg>
													{/* <div className="circlecenter" style={{ color: getProgressColor(Number(((v.paid / (v.total)) * 100).toFixed(0))),}}>{v.paidpayments} / {v.totalpayments}</div> */}
												</div>
												)}
										</div>
									))}
								</div>
							</div>
						</>
					)}
					<div className="footer">
						<div
							className={"button" + (site === "home" ? " selected" : "")}
							onClick={() => setSite("home")}
						>
							Home
						</div>
						<div
							className={"button" + (site === "vehicles" ? " selected" : "")}
							onClick={() => setSite("vehicles")}
						>
							Vehicles
						</div>
					</div>
				</div>
			</div>
		</AppProvider>
	);
}

const AppProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
	if (devMode) {
		return <div className="dev-wrapper">{children}</div>
	} else return children
}

export default App
