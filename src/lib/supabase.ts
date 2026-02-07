import { createClient } from '@supabase/supabase-js';
import type { Database } from './types';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL as string;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY as string;

export const supabase = createClient<Database>(supabaseUrl || '', supabaseAnonKey || '');

// Helper functions for data fetching

export async function getPosts(limit?: number) {
	let query = supabase
		.from('posts')
		.select('*')
		.order('published_at', { ascending: false });

	if (limit) {
		query = query.limit(limit);
	}

	const { data, error } = await query;
	if (error) throw error;
	return data;
}

export async function getPostBySlug(slug: string) {
	const { data, error } = await supabase
		.from('posts')
		.select('*')
		.eq('slug', slug)
		.single();

	if (error) throw error;
	return data;
}

export async function getEvents(upcoming = true) {
	const now = new Date().toISOString();
	let query = supabase.from('events').select('*');

	if (upcoming) {
		query = query.gte('event_date', now).order('event_date', { ascending: true });
	} else {
		query = query.lt('event_date', now).order('event_date', { ascending: false });
	}

	const { data, error } = await query;
	if (error) throw error;
	return data;
}

export async function getTalks() {
	const { data, error } = await supabase
		.from('talks')
		.select('*')
		.order('created_at', { ascending: false });

	if (error) throw error;
	return data;
}

export async function getTalkBySlug(slug: string) {
	const { data, error } = await supabase
		.from('talks')
		.select('*')
		.eq('slug', slug)
		.single();

	if (error) throw error;
	return data;
}

export async function getEventsByTalkSlug(talkSlug: string) {
	const { data, error } = await supabase
		.from('events')
		.select('*')
		.eq('talk_slug', talkSlug)
		.order('event_date', { ascending: true });

	if (error) throw error;
	return data;
}

export async function getVideos(limit?: number) {
	let query = supabase
		.from('videos')
		.select('*')
		.order('published_at', { ascending: false });

	if (limit) {
		query = query.limit(limit);
	}

	const { data, error } = await query;
	if (error) throw error;
	return data;
}
