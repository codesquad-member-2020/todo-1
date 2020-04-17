const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");

const ENTRY_FILE_LOGIN = path.resolve(__dirname, "../src", "js", "login.ts");
const ENTRY_FILE_TODO = path.resolve(__dirname, "../src", "js", "todo.ts");
const OUTPUT_DIR = path.resolve(__dirname, "../build");

const config = {
	mode: "production",
	entry: {
		login: ENTRY_FILE_LOGIN,
		todo: ENTRY_FILE_TODO,
	},
	resolve: {
		alias: {
			Scss: path.resolve(__dirname, "../src/scss/"),
		},
		extensions: [".js", ".jsx", ".tsx", ".ts", ".json"],
	},
	module: {
		rules: [
			{
				test: /\.(ts|tsx)$/,
				loader: "babel-loader",
				options: {
					presets: ["@babel/preset-typescript"],
				},
			},
			{
				test: /\.js$/,
				loader: "babel-loader",
				options: {
					presets: [
						"@babel/preset-env",
						{
							plugins: ["@babel/plugin-proposal-class-properties"],
						},
					],
				},
				exclude: /node_modules/,
			},
			{
				test: /\.scss$/,
				use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"],
				exclude: /node_modules/,
			},
		],
	},
	plugins: [
		new MiniCssExtractPlugin({
			filename: "style.css",
		}),
		new HtmlWebpackPlugin({
			filename: "login.html",
			template: path.join(__dirname, "../src/login.html"),
			hash: true,
			chunks: ["login"],
		}),
		new HtmlWebpackPlugin({
			filename: "todo.html",
			template: path.join(__dirname, "../src/todo.html"),
			hash: true,
			excludeChunks: ["login"],
		}),
	],
	output: {
		path: OUTPUT_DIR,
		filename: "[name].bundle.js",
	},
};

module.exports = config;
