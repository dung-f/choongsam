package com.postgre.choongsam.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class YouTubeApiController {

	@Value("${youtube.api.key}")
	private String apiKey;

	@Value("${youtube.api.base-url}")
	private String baseUrl;

	@GetMapping("/api/youtube/config")
	public YouTubeConfig getYouTubeConfig() {
		return new YouTubeConfig(apiKey, baseUrl);
	}

	static class YouTubeConfig {
		private String apiKey;
		private String baseUrl;

		public YouTubeConfig(String apiKey, String baseUrl) {
			this.apiKey = apiKey;
			this.baseUrl = baseUrl;
		}

		public String getApiKey() {
			return apiKey;
		}

		public String getBaseUrl() {
			return baseUrl;
		}
	}
}
