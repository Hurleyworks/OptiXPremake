// This header file was auto-generated by ClassMate++
// Created: 26 Jan 2019 8:47:47 pm
// Copyright (c) 2019, HurleyWorks

#pragma once

#include "Log.h"


namespace Jahley
{
	class App
	{
	public:
		virtual ~App();

		void run();

		virtual void update() {}
		virtual void onInit() {}
		virtual void onCrash() {}

		// crash handling
		void preCrash();
		void onFatalError(g3::FatalMessagePtr fatal_message);

	protected:
		App();

		bool isRunning = true;
		std::chrono::time_point<std::chrono::system_clock> startTime = std::chrono::system_clock::now();

	private:
		FatalErrorCallback errorCallback = nullptr;
		PreCrashCallback preCrashCallback = nullptr;
		LogHandler log;
		
	}; // end class App

	// Implemented by client
	App* CreateApplication();

} // namespace Jahley